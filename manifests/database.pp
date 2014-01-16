# = Define php5_mssql::database
#
#   This define add a database configuration in /etc/odbc.ini. With this define you can:
#     * add a new database on a already configured server (server may be configured through php5_mssql::server define or through another php5_mssql::database define)
#     * install and configure packages, add a single MSSQL and database with a single resource
#
# == Params
#
# [*host*]
#   hostname or ip_address of MSSQL server. Used only if server is not already defined
#
# [*port*]
#   port of MSSQL server. Used only if server is not already defined
#
# [*tds_version*]
#   version of tds to use. Default: 8.0. Used only if server is not already defined
#
# [*db_name*]
#   Database name. <name> will be used if it's not set
#
# [*description*]
#   Description of database. Optional
#
# [*servername*]
#   If you have already defined a MSSQL server with php5_mssql::server, this parameter must be resource's name.
#   Otherwise php5_mssql::server define is called and this parameter is used as define name
#
# == Examples
#
#   1) Define one MSSQL server and two databases on this server separately:
#
#     php5_mssql::server {'server1':
#       host  => 'x.y.z.k',
#       port  => 'xx'
#     }
#
#     php5_mssql::database {'database1':
#       servername  => 'server1'
#     }
#
#     php5_mssql::database {'database2':
#       servername  => 'server1'
#     }
#
#   2) Install and configure drivers. Add a single MSSQL server with a single database in a single resource:
#     php5_mssql::database{'database1':
#       host        => 'x.y.z.k',
#       port        => 'XX',
#       servername  => 'server1'
#     }
#
# == Author
#
#   Felice Pizzurro <felice.pizzurro@softecspa.it>
#
define php5_mssql::database (
  $host        = '',
  $port        = '',
  $tds_version = '8.0',
  $db_name     = '',
  $description = '',
  $servername,

) {

  include php5_mssql

  $dbname = $db_name? {
    ''      => $name,
    default => $db_name
  }

  if !defined(Php5_mssql::Server[$servername]) {
    if ($host != '' ) and ($port != '') {

      php5_mssql::server{$servername :
        host        => $host,
        port        => $port,
        tds_version => $tds_version,
      }

    }
    else {
      fail ("specify host and port or define resource Php5_mssql::Server[${servername}] separately")
    }
  }

  concat_fragment { "odbc.ini+002-${name}.tmp":
    content => template('php5_mssql/database.ini.erb')
  }
}
