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
}
