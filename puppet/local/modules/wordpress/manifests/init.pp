class wordpress {
  # Copy sample wp-config.php file
  exec { 'copy-wp-config-sample':
    command => "cp /var/www/myfossil/wp-config.php.sample /var/www/myfossil/wp-config.php",
    creates => "/var/www/myfossil/wp-config.php",
    require => [
      File['/home/vagrant/bin/wp'],
      File['vagrant-nginx-enable'],
      Exec['set-wp-permissions'],
    ],
  }
}
