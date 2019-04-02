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
    "tm",
    "wordcloud",    
    "httr"
  )
)

# Constants
kFilenamePt <- "Data/MemoriasPostumas.txt"
kProcessedBookFile <- "Data/MemoriasPostumas.rds"
# Assumes gcloud is properly installed and configured
# https://cloud.google.com/translate/docs/translating-text#translate_text_with_model-protocol
kApiToken <- system("gcloud auth application-default print-access-token", intern = TRUE)
kMaxNumberOfRetries <- 5

TranslateWithGoogleAndRetryIfNecessary <- function(apiToken, toTranslate, sourceLanguage, targetLanguage, maxRetries) {
  i <- 0
  result <- NULL

  while (i < maxRetries) {
    result <- TranslateWithGoogle(apiToken, toTranslate, sourceLanguage, targetLanguage)

    if (length(result) > 0) {
      break
    }
    else {
      # Retries after a second
      Sys.sleep(1)
    }
  }

  result
}

TranslatePtToEnWithGoogle <- function(toTranslate) {
  sapply(toTranslate, FUN = function(x) { TranslateWithGoogleAndRetryIfNecessary(kApiToken, x, 'pt', 'en', kMaxNumberOfRetries) })  
}

TranslateWithGoogle <- function(apiToken, text, sourceLanguage, targetLanguage) {
  r <- POST("https://translation.googleapis.com/language/translate/v2",
    accept_json(),
    content_type("application/json"),
    body = list(
      q =  text,
      source = sourceLanguage,
      target = targetLanguage,
      format = 'text'
    ),
    add_headers(Authorization = sprintf("Bearer %s", apiToken)),
    encode = "json"
  )
  
  httr::content(r)$data$translations[[1]]$translatedText
}

CleanupCorpus <- function(docs) {
    tm_map(docs, content_transformer(tolower)) %>%
    tm_map(., removeNumbers) %>%
    tm_map(., removeWords, stopwords('portuguese')) %>%
    tm_map(., removePunctuation) %>%
    tm_map(., stripWhitespace)
}

GetCorpusFromTextVector <- function(texts) {
    texts %>%
        trim %>%
        VectorSource %>% 
        Corpus %>% 
        CleanupCorpus
}

GetWordsFrequencies <- function(docs) {
    documentTermsMatrix <- docs %>% TermDocumentMatrix
    sparseTermsMatrix <- sparseMatrix(i=documentTermsMatrix$i, j=documentTermsMatrix$j, x=documentTermsMatrix$v)
    termsFrequencies <- sort(rowSums(sparseTermsMatrix), decreasing=TRUE)
    
    data.frame(word = documentTermsMatrix$dimnames$Terms, freq=termsFrequencies)
}

PlotWordsWithHighestFrequencies <- function(wordsFrequencies) {
    kMaxNumberOfWordsToPlotInWordCloud <- 64

    wordcloud(
        words = wordsFrequencies$word, 
        freq = wordsFrequencies$freq, 
        min.freq = 1, 
        max.words=kMaxNumberOfWordsToPlotInWordCloud, 
        random.order=FALSE,
        rot.per=0.35, 
        colors=brewer.pal(8, "Dark2"),
        scale=c(3.5, 0.2))
}

PlotMostFrequentCorpusWords <- function(corpus) {
    corpus %>% 
        GetWordsFrequencies %>%
        PlotWordsWithHighestFrequencies
}

# Preprocess book if necessary
if (!file.exists(kProcessedBookFile)) {
  print("Will run Google Translate engine on pt-br book!")

  memoriasPostumasChapters <- kFilenamePt %>% 
      readChar(., file.info(kFilenamePt)$size) %>%
      strsplit("CAPÍTULO [A-z]+") %>% 
      sapply(., FUN = removeNumbers) %>% #Removes standalone numbers in the text
      sapply(., FUN = trimws) %>%
      data.frame(chapter_text = .) %>% 
      mutate(., chapter = row_number() - 1) %>%
      filter(chapter > 0) %>% # Removes any preamble before the first chapter
      mutate(., chapter_text_en =  chapter_text %>% TranslatePtToEnWithGoogle)

  saveRDS(memoriasPostumasChapters, file = kProcessedBookFile)
} else {
  print("Book already exists! Loading from rds file")

  memoriasPostumasChapters <- readRDS(file = kProcessedBookFile)
}

