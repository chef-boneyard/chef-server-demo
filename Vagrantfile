require 'URI'

Vagrant::Config.run do |config|

  chef_config = {
    "topology" => "standalone",
    "api_fqdn" => "api.chef.server",
    "manage_fqdn" => "manage.chef.server"
  }

  # .deb cache paths
  host_cache_path = "pkg"
  guest_cache_path = "/tmp/cache"

  # look for the installer override ENV var
  if ENV['OSC_INSTALLER']
    # if the ENV var is a URI set it and let chef-solo pull it down
    if URI.parse(ENV['OSC_INSTALLER']).absolute?
      chef_config[:installer_file] = ENV['OSC_INSTALLER']
    # if the ENV var is in the host cache use it
    elsif File.exists?(ENV['OSC_INSTALLER']) ||
        File.exists?("#{host_cache_path}/#{File.basename(ENV['OSC_INSTALLER'])}")
      chef_config[:installer_file] = "#{guest_cache_path}/#{File.basename(ENV['OSC_INSTALLER'])}"
    end
  end

  # Mount a folder to cache our installers
  config.vm.share_folder "cache", guest_cache_path, host_cache_path

  config.vm.define "chef-server" do |chefs_config|

    chefs_config.vm.box = "opscode-ubuntu-10.04"
    chefs_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-10.04.box"
    #chefs_config.vm.box = "opscode-ubuntu-12.04"
    #chefs_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"

    chefs_config.vm.host_name = "chefserver"

    config.vm.provision :chef_solo do |chef|

      chef.log_level = :debug
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "chef-server::provision"
      chef.json = {
        'chef-server' => chef_config
      }
    end

    # Set up local dev helpers
    config.vm.provision :chef_solo do |chef|

      chef.log_level = :debug
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "chef-server-demo"
    end
  end
end

