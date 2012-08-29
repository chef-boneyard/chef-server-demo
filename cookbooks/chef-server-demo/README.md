Description
===========
Additional configuration for demo version of chef-server.
Sets up PATH and a user.

Requirements
============
Assumes a erchef-based open source chef server has been set up
and has configuration in `/etc/chef-server`

Attributes
==========

### installer_file
Location of installer file, either on local file system or as a
URL of a remote installer.

### configuration
A map of additional configuration key value pairs to be inserted
into `/etc/chef-server/chef-server.rb`

LICENSE
=======
Copyright 2012, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


