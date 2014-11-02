class wpcli {
  # Install the wp-cli software
  exec { 'retrieve_wpcli':
    command => "/usr/bin/wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar",
    creates => "/usr/local/bin/wp",
    require => [
      Package['php5-fpm'],
      Package['php5-mysql']
    ],
  }

  # Set wp-cli permissions
  file { '/usr/local/bin/wp':
    mode => 0755,
    require => Exec['retrieve_wpcli'],
  }
}
