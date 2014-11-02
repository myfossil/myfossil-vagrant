class wpcli {
  # Install the wp-cli software
  exec { 'retrieve_wpcli':
    command => "/usr/bin/wget -O /home/vagrant/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar",
    creates => "/home/vagrant/bin/wp",
    require => [
      File['/home/vagrant/bin'],
      Package['php5-fpm'],
      Package['php5-mysql']
    ],
  }

  file { '/home/vagrant/bin/wp':
    mode => 0755,
    require => Exec['retrieve_wpcli'],
  }
}
