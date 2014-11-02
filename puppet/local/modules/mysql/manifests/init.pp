class mysql {
  $mysql_root_passwd = "wp_myfossil"
  $wp_database = "wp_myfossil"
  $wp_database_test = "wp_myfossil_test"
  $wp_db_username = "wp_myfossil"
  $wp_db_password = "wp_myfossil"

  # Install mysql
  package { 'mysql-server':
    ensure => present,
    require => Exec['apt-get update'],
  }

  package { 'mysql-client':
    ensure => present,
    require => Exec['apt-get update'],
  }

  # Run mysql
  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }

  # Use a custom mysql configuration file
  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/mysql.conf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  # We set the root password here
  exec { 'set-mysql-password':
    unless  => "mysql --user=root --password=${mysql_root_passwd} ${wp_database} -e exit",
    command => "mysqladmin --user=root password ${mysql_root_passwd}",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'],
  }

  # Create WordPress database
  exec { 'create-wp-database':
    unless  => "mysql --user=root --password=${mysql_root_passwd} ${wp_database} -e exit",
    command => "mysqladmin --user=root --password=${mysql_root_passwd} create ${wp_database}",
    path    => ['/bin', '/usr/bin'],
    require => [
      Service['mysql'], 
      Package['mysql-client'],
      Exec['set-mysql-password'],
    ],
  }

  # Set WordPress database permissions
  exec { 'set-wp-database-permissions':
    command => "mysql --user=root --password=${mysql_root_passwd} ${wp_database} -e \"GRANT ALL PRIVILEGES ON ${wp_database}.* TO \'${wp_db_username}\'@\'%\' IDENTIFIED BY \'${wp_db_password}\'; FLUSH PRIVILEGES;\"",
    path    => ['/bin', '/usr/bin'],
    require => [
      Service['mysql'], 
      Package['mysql-client'],
      Exec['create-wp-database']
    ],
  }

  # Create WordPress test database
  exec { 'create-wp-test-database':
    unless  => "mysql --user=root --password=${mysql_root_passwd} ${wp_database_test} -e exit",
    command => "mysqladmin --user=root --password=${mysql_root_passwd} create ${wp_database_test}",
    path    => ['/bin', '/usr/bin'],
    require => [
      Service['mysql'], 
      Package['mysql-client'],
      Exec['set-mysql-password'],
    ],
  }

  # Set WordPress test database permissions
  exec { 'set-wp-test-database-permissions':
    command => "mysql --user=root --password=${mysql_root_passwd} ${wp_database_test} -e \"GRANT ALL PRIVILEGES ON ${wp_database_test}.* TO \'${wp_db_username}\'@\'%\' IDENTIFIED BY \'${wp_db_password}\'; FLUSH PRIVILEGES;\"",
    path    => ['/bin', '/usr/bin'],
    require => [
      Service['mysql'], 
      Package['mysql-client'],
      Exec['create-wp-database']
    ],
  }
}
