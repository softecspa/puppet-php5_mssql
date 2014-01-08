# = Define php5_mssql::server
#
#   This define add a MSSQL server in /etc/freetds/freetds.conf. Define's name is used by php5_mssql::database define to retrieve a database.
#
# == Params
#
# [*host*]
#   hostname or ip_address of MSSQL server
#
# [*port*]
#   port of MSSQL server
#
# [*tds_version*]
#   version of tds to use. Default: 8.0
#
# == Examples
#
#   include php5_mssql
#   php5_mssql::server {'server1':
#     host  => 'xxx.xxx.xxx.xxx',
#     port  => 'zz'
#   }
#
#   If we want to use database named "products" stored on above defined server:
#
#   php5_mssql::database { 'products':
#     description => 'product database',
#     servername  => 'server1'
#   }
#
# == Author
#
#   Felice Pizzurro <felice.pizzurro@softecspa.it>
#
define php5_mssql::server (
  $host,
  $port,
  $tds_version = '8.0'
) {

  if !is_integer($port) {
    fail ('port must be an integer value')
  }

  $servername = $name

  concat_fragment { "freetds.conf+002-${name}.tmp":
    content => template('php5_mssql/server.ini.erb')
  }

}
