class php5_mssql::install {

  include php5_mssql::params

  php5::module { $php5_mssql::params::php5_modules :
    ensure  => 'pin'
  }

  package { $php5_mssql::params::packages :
    ensure  => present
  }
}
