exec { 'apt-get update':
    path => '/usr/bin',
}

package { 'vim':
    ensure => present,
}

file { '/var/www/':
    ensure => 'directory',
}

file { '/home/vagrant/bin':
    ensure => 'directory',
}

include nginx, php, mysql, wpcli
