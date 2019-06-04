RequireLibraries <- function(libraries) {
  newLibs <- libraries[!(libraries %in% installed.packages()[,"Package"])]
  
  if (length(newLibs) > 0) {
    install.packages(newLibs)
  }
  
  # Apply requires
  sapply(libraries, FUN = RequireByName)
}

#Functions
RequireByName <- function(lib) { 
  require(lib, character.only = TRUE)
}

RequireLibraries(
  c(
    "XML",
    "httr",
    "stringr"
  )
)

kMarylandElectionUrl <- "http://www.elections.state.md.us/elections/2012/election_data/index.html"

webpage <- readLines(kMarylandElectionUrl) %>%
  htmlParse

links <- webpage %>% getHTMLLinks
filenames <- links[str_detect(links, "_General.csv")]

sapply(filenames, FUN = function(file) {
  baseUrl <- "http://www.elections.state.md.us/elections/2012/election_data/"
  download.file(paste(baseUrl, file, sep = ""), destfile = paste("/tmp/", file, sep = ""))
})
