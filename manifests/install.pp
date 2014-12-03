class php5_mssql::install {

  include php5_mssql::params

  softec_php::extension { $php5_mssql::params::php5_modules :}

  package { $php5_mssql::params::packages :
    ensure  => present
  }
}
