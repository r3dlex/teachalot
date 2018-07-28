library(forecast) #autoarima, arima, acf, pacf
library(magrittr)

x  <- arima.sim(n = 1000, list(ar = c(0.8)))

x %>% 
  paste0('x = ') %>%
  print

acf(x)
pacf(x)

# arima(p, d, q)
# p - ordem do modelo
y <- arima(x, order = c (1, 0 ,0))

x2 <- auto.arima(WWWusage)
print(x2)
