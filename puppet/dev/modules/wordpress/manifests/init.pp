class wordpress {

  # Copy sample wp-config.php file
  exec { 'copy-wp-config-sample':
    command => "cp /var/www/myfossil-dev/wp-config.php.dist /var/www/myfossil-dev/wp-config.php",
    creates => "/var/www/myfossil-dev/wp-config.php",
    require => [
      File['/usr/local/bin/wp'],
      File['vagrant-nginx-enable'],
      Exec['set-wp-permissions'],
    ],
  }

}
