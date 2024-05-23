library(jsonlite)

read_track <- function(fname) {
    track <- fromJSON(fname)
    track <- as.data.frame(track)
}
