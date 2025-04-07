library(DBI)
library(RPostgres)

get_connection <- function() {
  dbConnect(RPostgres::Postgres(),
    dbname = "radiacode",
    host = "localhost"
  )
}

load_sql_function <- function(func_name, con) {
  fn <- readLines(paste0("sql/", func_name, ".sql"))
  q <- paste(fn, collapse = "\n")
  dbExecute(con, q)
}
