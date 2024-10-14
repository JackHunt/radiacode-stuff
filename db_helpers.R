library(DBI)
library(RPostgres)

get_connection <- function() {
  con <- dbConnect(RPostgres::Postgres(),
    dbname = "radiacode",
    host = "localhost"
  )

  fns <- readLines("sql/functions.sql")
  q <- paste(fns, collapse = "\n")
  dbExecute(con, q)

  return(con)
}
