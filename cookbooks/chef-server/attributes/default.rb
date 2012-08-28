#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Copyright:: Copyright (c) 2012 Opscode, Inc.
#
# All Rights Reserved
#

###
# High level options
###

default['chef-server']['installer_file'] = nil

###
# Underlying Configuration for /etc/opscode/chef-server.rb
###
default['chef-server']['configuration'] = {}
