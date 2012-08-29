#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Copyright:: Copyright (c) 2012 Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# install

installer_file = node['chef-server']['installer_file']
installer_name = ::File.basename(installer_file)
installer_path = "#{Chef::Config[:file_cache_path]}/#{installer_name}"

if ::URI.parse(installer_file).absolute?
  remote_file installer_path do
    source installer_file
    checksum node['chef-server']['installer_checksum']
    action :create
  end
else
  installer_path = installer_file
end

package installer_name do
  source installer_path
  provider Chef::Provider::Package::Dpkg if platform?("ubuntu","debian")
  action :install
end

# configure

directory "/etc/chef-server" do
  owner "root"
  group "root"
  recursive true
  action :create
end

template "/etc/chef-server/chef-server.rb" do
  source "chef-server.rb.erb"
  owner "root"
  group "root"
  action :create
  notifies :run, "execute[reconfigure-chef-server]", :immediately
end

execute "reconfigure-chef-server" do
  command "chef-server-ctl reconfigure"
  action :nothing
end

# ensure the node can resolve the FQDNs locally
[ node['chef-server']['api_fqdn'],
  node['chef-server']['manage_fqdn'] ].each do |fqdn|

  execute "echo 127.0.0.1 #{fqdn} >> /etc/hosts" do
    not_if "host #{fqdn}" # host resolves
    not_if "grep -q #{fqdn} /etc/hosts" # entry exists
  end
end
