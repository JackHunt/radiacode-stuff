library(optparse)
library(jsonlite)

# rctrk files are basically just JSON files of the form (for example):
# {
#   "devices" : [
#     "<some_device_id>"
#   ],
#   "periods" : [
#     {
#       "distance" : 8529.77,
#       "start" : 1723382107,
#       "end" : 1723390166
#     }
#   ],
#   "markers" : [
#     {
#       "lat" : <a_latitude>,
#       "countRate" : 5.41,
#       "doseRate" : 7.31,
#       "date" : 1723382108,
#       "lon" : <a_longitude>
#     },
#    ],
#    "start" : 1723382107,
#    "title" : "Track 11.08.2024 14:15:07",
#    "sv" : false
# }

parse_rctrk <- function(fname) {
  if (!file.exists(fname)) {
    stop(paste("The specified file does not exist:", fname))
  }

  raw <- fromJSON(fname)
  session_data <- raw[c("devices", "periods", "start", "title", "sv")]
  markers <- as.data.frame(raw$markers)
  markers <- markers[, c("date", "lat", "lon", "countRate", "doseRate")]

  list(
    session_data = session_data,
    markers = markers
  )
}

load_tracks <- function(in_dir) {
  if (!dir.exists(in_dir)) {
    stop(paste("The specified directory does not exist:", in_dir))
  }

  rctrk_files <- list.files(in_dir, pattern = "\\.rctrk$", full.names = TRUE)
  if (length(rctrk_files) == 0) {
    stop(paste("No *.rctrk files found in the specified directory:", in_dir))
  }

  lapply(rctrk_files, parse_rctrk)
}

if (!interactive()) {
  opt_parser <- OptionParser(option_list = list(
    make_option(c("-d", "--dir"),
      type = "character",
      default = NULL,
      help = "Input directory"
    ),
    make_option(c("-o", "--out_fname"),
      type = "character",
      default = "tracks",
      help = "Output filename (without extension)"
    )
  ))

  opt <- parse_args(opt_parser)

  if (is.null(opt$dir)) {
    stop("A directory must be specified.")
  }

  if (is.null(opt$out_fname)) {
    stop("An output filename prefix must be specified.")
  }

  tracks <- load_tracks(opt$dir)
  saveRDS(tracks, paste0(opt$out_fname, ".rds"))
}
