class php5_mssql (
  $file_usage = 1,
  $cp_timeout = 5,
  $cp_reuse   = 5,
) {

  include php5_mssql::install
  include php5_mssql::config

  Class['php5_mssql::install'] ->
  Class['php5_mssql::config']

}
