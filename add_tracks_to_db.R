library(optparse)

source("db_helpers.R")

process_tracks <- function(tracks, con) {
  #
}

if (!interactive()) {
  opt_parser <- OptionParser(option_list = list(
    make_option(c("-i", "--in_rds"),
      type = "character", default = NULL,
      help = "Path to the *.rds file."
    )
  ))

  opt <- parse_args(opt_parser)

  if (is.null(opt$dir)) {
    stop("Path to the *.rds file must be specified.")
  }

  if (!grepl("\\.rds$", opt$in_rds)) {
    stop(paste(c("Specified file", opt$in_rds, "is not an *.rds file.")))
  }

  tracks <- readRDS(opt$in_rds)
  con <- get_connection()
  process_tracks(tracks, con)
}
