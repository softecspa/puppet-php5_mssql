class php5_mssql::config {

  include php5_mssql::params

  File {
    owner => 'root',
    group => 'root',
    mode  => '644'
  }

  file {$php5_mssql::params::odbcinst :
    ensure  =>  present,
    content => template('php5_mssql/odbcinst.ini.erb'),
  }

  concat_build { 'odbc.ini':
    order   => ['*.tmp'],
    target  => $php5_mssql::params::odbcini
  }

  concat_fragment { 'odbc.ini+001.tmp':
    content => "#Generated by puppet"
  }

  concat_build { 'freetds.conf':
    order   => ['*.tmp'],
    target  => $php5_mssql::params::freetds_conf
  }

  concat_fragment { 'freetds.conf+001.tmp':
    content => "#Generated by puppet"
  }

  file { $php5_mssql::params::odbcini :
    ensure  => present,
    require => Concat_build['odbc.ini'],
  }

  file { $php5_mssql::params::freetds_conf :
    ensure  => present,
    require => Concat_build['freetds.conf'],
  }
}
