library(magrittr)
library(purrr)
library(futile.logger)
library(nominatim)


geocodeWithOsm <- function (address) {
    t <- Sys.time()
    geocode.response <- osm_geocode(address)
    t <- difftime(Sys.time(), t, 'secs')
    flog.info(paste0("Geocode response: ", geocode.response))

    data.frame(address = address, geocode.response, elapsed_time = t)
}

getTempFilename <- function(infile) { sprintf("%s_%s", infile, "temp_geocoded_osm.rds") }


getStartIndex <- function(infile) {
    # find out where to start in the address list (if the script was interrupted before):
    startIndex <- 1
    #if a temp file exists - load it up and count the rows!

    if (file.exists(temp.filename)) {
        print("Found temp file - resuming from index:")
        geocoded <- readRDS(temp.filename)
        startIndex <- nrow(geocoded)

        print(paste0("Start Index: ", startIndex))
    }

    startIndex
}

data.csv <- read.csv("Data/AndreBem-Empresas.csv")
#initialise a dataframe to hold the results
geocoded <- data.frame()

addresses <- data.csv$CEP
# addresses <- paste0(addresses)
#input addresses
# addresses <- c("Baker Street 221b, London", "Brandenburger Tor, Berlin", 
    #"Platz der Deutschen Einheit 1, Hamburg", "Arc de Triomphe de l’Etoile, Paris")

#wip base filename
infile <- "input"
temp.filename <- getTempFilename(infile)

startIndex <- getStartIndex(infile)
geocoded <- data.frame()

for (ii in seq(startIndex, length(addresses))) {
   print(paste("Working on index", ii, "of", length(addresses)))
   flog.info(paste0("Querying with address: ", addresses[ii]))
   result <- addresses[ii] %>% geocodeWithOsm

   print(result$status)     
   result$index <- ii
   #appends the answer to the results file.
   names(result) <- c("address","long", "lat", "elapsed_time", "index")
   geocoded <- rbind(geocoded, result)
   #save temporary results as we are going along
   saveRDS(geocoded, temp.filename)
}

#now we add the latitude and longitude to the main data
#Saves final results to output files
write.table(geocoded, file=paste0("Data/", infile ,"_geocoded_osm.csv"), sep=",", row.names=FALSE)
saveRDS(geocoded, paste0("Data/", infile ,"_geocoded_osm.rds"))