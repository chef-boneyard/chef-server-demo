Chef-server demo
================

Overview
--------

Welcome to Erchef, the new Erlang based Chef server. This
repository contains a `Vagrantfile` and installation cookbooks to
set up a self-contained vm running a complete Chef server environment
for your demo pleasure.

Setting it up
-------------

In order to get started you need to have a copy of the latest omnibus
generated `.deb` for chef-server.  You can get this [here]. Then, it's
simply a matter of copying the `.deb` into a location that is shared
with the vm and starting vagrant.

1. Install [VirtualBox][] (exercise left to the reader) and then
   install required gems using bundler:
   
       which bundle || gem install bundler
       bundle install --binsubs

2. Copy the [Chef server omnibus .deb][] into the pkg
   sub-directory:

       curl -O $URL_FOR_CHEF_SERVER_DEB
       # mv download to pkg/

3. Export environment variable `OSC_INSTALLER`, setting it to point at
   the omnibus installer .deb and provision your Erchef powered Chef server:

      export OSC_INSTALLER=pkg/chef-server_0.10.8-198-g6d59524-1.ubuntu.10.04_amd64.deb
      bin/vagrant up

[Chef server omnibus .deb]: http://wiki.opscode.com
[VirtualBox]: https://www.virtualbox.org/wiki/Downloads

Test drive time
---------------

You can log into your Chef server demo vm like this:

    bin/vagrant ssh

The `open-source-demo::default` recipe will have created a
`$HOME/.chef/knife.rb` for you so that you can start issueing knife
commands right away:

    knife client list
    export EDITOR=vi
    knife node create
    knife node list
    
The recipe also sets the `PATH` to include the command line tools for
the versions of postgres, rabbit, and erlang supplied in the omnibus
installer .deb. To get an overview of the Chef server system status
try this:

    sudo chef-server-ctl status

Controlling the server
-----------------------

There is a single init.d style control script `chef-server-ctl` which
controls all daemons used by the chef-server. This also provides the
ability to tail all the logs produced by the individual services. *Use
sudo or a root shell when using `chef-server-ctl`*.

    sudo chef-server-ctl  help

LICENSE
-------

Copyright 2012 Opscode, Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
