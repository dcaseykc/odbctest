#' Test ODBC stuff
#'
#' @param server name of server
#' @param database name of DB
#' @param mykey name of key stored via keyring with permissions to DB
#'
#' @importFrom keyring key_get key_list
#' @importFrom DBI dbConnect dbDisconnect dbGetQuery
#' @importFrom odbc odbc
#'
hello <- function(server, database, mykey) {
  con <- DBI::dbConnect(odbc::odbc(),
                        driver = 'ODBC Driver 17 for SQL Server',
                        server = server,
                        database = database,
                        uid = keyring::key_list(mykey)[["username"]],
                        pwd = keyring::key_get(mykey, keyring::key_list(mykey)[["username"]]),
                        Encrypt = 'yes',
                        TrustServerCertificate = 'yes',
                        Authentication = 'ActiveDirectoryPassword')

  dbDisconnect(con)
  return(1)

}
