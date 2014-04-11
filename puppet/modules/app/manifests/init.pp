
class app($node_version = "v0.10.26") {
    # Add some default path values
    Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin', "/home/vagrant/nvm/${node_version}/bin"], }

    # Base packages and ruby gems (sass, compass)
    class { essentials: }

    # Install and setup nginx web server
    class { nginx:
        require => [Class["essentials"]]
    }

    # Install node through NVM
    class { 'nvm':
        node_version => $node_version,
        require => [Class["essentials"]]
    }

    # This function depends on some commands in the nvm.pp file
    define npm( $directory="/home/vagrant/nvm/${app::node_version}/lib/node_modules" ) {
      exec { "install-${name}-npm-package":
        unless => "test -d ${directory}/${name}",
        command => "npm install -g ${name}",
        require => Exec['install-node'],
      }
    }

    # Global npm modules
    npm { ["grunt-cli"]:
    }

    # Examples of installing packages from a package.json if we need to.
    exec { "npm-install-packages":
      cwd => "/vagrant",
      command => "npm install",
      require => Exec['install-node'],
    }

    class{ 'postgresql::globals':
      version               => '9.3',
      manage_package_repo   => true,
    }->
    class { 'postgresql::server':
      ip_mask_allow_all_users    => '0.0.0.0/0',
      ip_mask_deny_postgres_user => '0.0.0.0/32',
      listen_addresses           => '*',
      postgres_password          => 'postgres',
    }->
    class { 'postgresql::lib::devel': }

    postgresql::server::role { 'vagrant':
      password_hash => postgresql_password('vagrant', 'postgres')
    }

}
