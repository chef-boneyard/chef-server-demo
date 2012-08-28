#
# Author:: James Casey (<james@opscode.com>)
# Copyright:: Copyright (c) 2012 Opscode, Inc.
#
# All Rights Reserved
#

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
