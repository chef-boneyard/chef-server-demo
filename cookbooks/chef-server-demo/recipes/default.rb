#
# Author:: James Casey (<james@opscode.com>)
#
# Copyright 2012, Opscode, Inc
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

# Ensure the private chef bin/ dir is first in our PATH
file "/etc/profile.d/omnibus-embedded.sh" do
  content "export PATH=\"/opt/chef-server/embedded/bin:$PATH\""
  action :create
end

# setup knife for vagrant

directory "/home/vagrant/.chef" do
  owner "vagrant"
  group "vagrant"
  mode 0700
  action :create
end

%w{admin chef-validator}.each do |user|
  execute "copy #{user}.pem" do
    command "/bin/cp /etc/chef-server/#{user}.pem /home/vagrant/.chef"
    creates "/home/vagrant/.chef/#{user}.pem"
    action :run
  end
  file "/home/vagrant/.chef/#{user}.pem" do
    mode "0600"
    owner "vagrant"
    group "vagrant"
  end
end

template "/home/vagrant/.chef/knife.rb" do
  mode "0755"
  owner "vagrant"
  group "vagrant"
end
