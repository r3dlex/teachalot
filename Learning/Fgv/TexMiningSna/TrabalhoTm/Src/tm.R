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
    "dplyr", #mutate, %>%
    "tm"
    "wordcloud"
  )
)

kFilename <- "Data/MemoriasPostumas.txt"


memoriasPostumasChapters <- kFilename %>% 
    readChar(., file.info(kFilename)$size) %>%
    strsplit("CAPÍTULO [A-z]+") %>% 
    sapply(., FUN = removeNumbers) %>% #Removes standalone numbers in the text
    sapply(., FUN = trimws) %>%
    data.frame(chapter_text = .) %>% 
    mutate(., chapter = row_number() - 1) %>%
    filter(chapter > 0) # Removes any preamble before the first chapter

