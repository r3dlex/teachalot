library(ggmap)
library(magrittr)
library(purrr)
library(logging)

waitAndRetryGetGeocodeAfter <- function(address, waitInSeconds) {
    print(time)
    Sys.sleep(waitInSeconds)
    getGeocode(address, waitInSeconds * 2)
}

#define a function that will process googles server responses for us.
getGeocode <- function(address, waitInSeconds = 1) {   
   #use the gecode function to query google servers
   response <- geocode(address, output="all", source = "osm", messaging=TRUE, override_limit=TRUE)

   if (response[[1]]$status != "OK") {
       logging.info(paste0("Got Status: %s", response$status))
       waitAndRetryGetGeocodeAfter(address, waitInSeconds);
   }
   else {
       response
   }
}

geocodeToDataFrame <- function(geocode) {
    geocode <- data.frame(lat=NA, long=NA, accuracy=NA, formatted_address=NA, address_type=NA, status=NA)
    geocode$lat <- geo_reply$results[[1]]$geometry$location$lat
    geocode$long <- geo_reply$results[[1]]$geometry$location$lng   

    if (length(geo_reply$results[[1]]$types) > 0) {
        geocode$accuracy <- geo_reply$results[[1]]$types[[1]]
    }
    
    geocode$address_type <- paste(geo_reply$results[[1]]$types, collapse=',')
    geocode$formatted_address <- geo_reply$results[[1]]$formatted_address

    geocode
}

getTempFilename <- function(infile) { sprintf("%s_%s", infile, "temp_geocoded.rds") }

getStartIndex <- function(infile) {
    # find out where to start in the address list (if the script was interrupted before):
    startIndex <- 1
    #if a temp file exists - load it up and count the rows!
    temp.filename <- getTempFilename(infile)

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
addresses <- paste0(addresses, ", Brazil")

#wip base filename
infile <- "input"
startIndex <- getStartIndex(infile)
 
# Start the geocoding process - address by address. geocode() function takes care of query speed limit.
for (ii in seq(startIndex, length(addresses))) {
   print(paste("Working on index", ii, "of", length(addresses)))
   #query the google geocoder - this will pause here if we are over the limit.
   result <- addresses[ii] %>%
    getGeoDetails %>%
    geocodeToDataFrame

   print(result$status)     
   result$index <- ii
   #appends the answer to the results file.
   geocoded <- rbind(geocoded, result)
   #save temporary results as we are going along
   saveRDS(geocoded, temp.filename)
}

#now we add the latitude and longitude to the main data
data$lat <- geocoded$lat
data$long <- geocoded$long
data$accuracy <- geocoded$accuracy

#Saves final results to output files
saveRDS(data, paste0("../Data/", infile ,"_geocoded.rds"))
write.table(data, file=paste0("../Data/", infile ,"_geocoded.csv"), sep=",", row.names=FALSE)