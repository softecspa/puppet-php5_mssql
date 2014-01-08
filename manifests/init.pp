# = Class php5_mssql
#
# This class install and configure mssql driver for php5. It install php5-sybase and tdsodbc packages.
#
# == Params
#
# [*file_usage*]
#   parameter FileUsage for odbc configuration. Default: 1
#
# [*cp timeout*]
#   parameter CPTimmeout for odbc configuration. Default: 5
#
# [*cp_reuse*]
#   parameter CPReuse for odbc configuration. Default: 1
#
# == Examples
#
#   To install mssql driver you only need to include class using default parameters or customizing it in class declaration
#
#   1) use default:
#     include php5_mssql
#
#   2) customize params:
#     class {'php5_mssql':
#       file_usage  => X,
#       cp_timeout  => Y,
#       cp_reuse    => Z
#     }
#
# == HowTo use
#
#   After installation, you have to define:
#     * one or more MSSQL server. Servers can be added by php5_mssql::server define
#     * one or more databases, each one relied to a defined MSSQL server. Databases can be added by php5_mssql::database define
#
#   If you have to use a single MSSQL server and a single database, you can install and configure all that you need using php5_mssql::database define
#
# == Author
#
#   Felice Pizzurro <felice.pizzurro@softecspa.it>
#
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
