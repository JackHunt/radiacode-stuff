library(DBI)
library(optparse)

source("db_helpers.R")

add_devices <- function(devices, con) {
  load_sql_function("add_device", con)

  lapply(devices, function(device) {
    dbGetQuery(con, sprintf("SELECT add_device('%s');", device))
  })
}

add_session <- function(session_data, devices, con) {
  load_sql_function("add_session", con)

  devices_sql <- paste0("ARRAY[", paste(lapply(devices, function(d) {
    d$add_device
  }), collapse = ","), "]")

  dbGetQuery(con, sprintf(
    "SELECT add_session('%s', %d, %s);",
    session_data$title,
    session_data$start,
    devices_sql
  ))
}

add_markers <- function(session_key, markers, con) {
  lapply(markers, function(marker) {
    #
  })
}

process_tracks <- function(tracks, con) {
  lapply(tracks, function(track) {
    session_data <- track$session_data
    device_keys <- add_devices(session_data$devices, con)
    session_key <- add_session(session_data, device_keys, con)
    add_markers(session_key, track$markers, con)
  })
}

if (!interactive()) {
  opt_parser <- OptionParser(option_list = list(
    make_option(c("-i", "--in_rds"),
      type = "character", default = NULL,
      help = "Path to the *.rds file."
    )
  ))

  opt <- parse_args(opt_parser)

  if (is.null(opt$in_rds)) {
    stop("Path to the *.rds file must be specified.")
  }

  if (!grepl("\\.rds$", opt$in_rds)) {
    stop(paste(c("Specified file", opt$in_rds, "is not an *.rds file.")))
  }

  tracks <- readRDS(opt$in_rds)
  con <- get_connection()
  process_tracks(tracks, con)
}

tracks <- readRDS("tracks.rds")
con <- get_connection()
process_tracks(tracks, con)
