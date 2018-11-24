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
    "janeaustenr", #austen_books,
    "ggplot2", #plots
    "stringr", #str_detect
    "tidytext", #unnest_tokens,
    "wordcloud"
  )
)

austenLineNumber <- austen_books() %>% 
  group_by(., book) %>% 
  mutate(., linenumber = row_number())

austenChapters <- mutate(
  austenLineNumber,
  chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", ignore_case = TRUE)))
)

austenUngrouped <- austenChapters %>% 
  ungroup

austenTokens <- austenUngrouped %>% 
  unnest_tokens(
    ., 
    token = "words", 
    input = text, 
    to_lower = TRUE, 
    output = word, # Output column name
    drop = TRUE # Removes original column from source data frame
  ) %>%
  mutate( # This mutate removes numerical values.
    ., 
    word = str_extract(word, "[a-z]+")
  )  

austenTokensNoStopwords <- austenTokens %>%
  anti_join( # Will remove all stop words from corpus
    .,
    stop_words,
    by = c("word" = "word")
  ) %>%
  filter(., !is.na(word))

austenCount <- count(austenTokensNoStopwords, word)
booksWordCloud <- with(austenCount, wordcloud(word, n, max.words = 100))

# TF-DF part
austenTfDfCount <- austenTokens %>% 
  count(book, word, sort = TRUE)

totalWordsPerBook <- austenTfDfCount %>% group_by(book) %>%
  summarize(total = sum(n))

austenTfDfCount <- left_join(austenTfDfCount, totalWordsPerBook)

wordCountsPlot <- ggplot(austenTfDfCount, aes(n/total, fill = book)) + 
  geom_histogram(show.legend = FALSE) + xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = "free_y")

freqByRank <- austenTfDfCount %>% 
  group_by(book) %>%
  mutate(rank = row_number(), tf = n/total)

freqPlot <-freqByRank %>% ggplot(aes(rank, tf, color = book)) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  scale_x_log10() +
  scale_y_log10()

# Gets linear regression and uses it's coefficients to draw an abline
lmRank <- freqByRank %>% 
  filter(rank < 500, rank > 10) %>% 
  lm(log10(tf) ~ log10(rank), data = .)

freqByRank %>% 
  ggplot(aes(rank, tf, color = book)) +
  geom_abline(intercept = coef(lmRank)[[1]], slope = coef(lmRank)[[2]], color = "gray50", linetype = 2) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  scale_x_log10() +
  scale_y_log10()

austenTfIdf <- austenTfDfCount %>% 
  bind_tf_idf(word, book, n)

tfIdfPlot <- austenTfIdf %>% arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  group_by(book) %>% 
  top_n(15) %>%
  ungroup %>%
  ggplot(aes(word, tf_idf, fill = book)) + geom_col(show.legend = FALSE) + labs(x = NULL, y = "tf-idf") + facet_wrap(~book, ncol = 2, scales = "free") + coord_flip()
