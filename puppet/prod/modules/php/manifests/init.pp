class php {
  # Install the php5-fpm and php5-cli packages
  package { ['php5-fpm',
             'php5-cli',
             'php5-mysql',
             'php5-gd']:
    ensure => present,
    require => Exec['apt-get update'],
  }

  # Make sure php5-fpm is running
  service { 'php5-fpm':
    ensure => running,
    require => Package['php5-fpm'],
  }
}
