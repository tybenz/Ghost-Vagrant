class upstart {

    file { "app-conf":
        ensure  => file,
        path => "/etc/init/app.conf",
        source => "puppet:///modules/app/config/app.conf"
    }

    service { 'app':
        ensure => running,
        provider => 'upstart',
        require => File['app-conf'],
    }

}
