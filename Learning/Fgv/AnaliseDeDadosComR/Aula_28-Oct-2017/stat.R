library(ggplot2)

gerar.amostra <- function(n)
{
  a <- rep(0, 10e4)

  for (i in 1:n)
  {
    a = a + runif(10e4)
  }

  a <- a / n
  
  return (a)
}

gerar.hist <- function(n)
{
  for (i in c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100))
  {
    x <- gerar.amostra(i)
    hist(x, xlab=sprintf("gerar.amostra(%d)", i))
  }
}

#gaussiana
gerar.normal <- function()
{
  y <- c()
  amostras <- c(10, 20, 30, 40)#, 50, 60, 70, 80, 90, 100)

  for (i in amostras)
  {
    y <- c(y, gerar.amostra(i))
  }

  y.df <- data.frame(y)
  print(names(y.df))

  ggplot(y.df) +
   geom_density(aes(y[1]), color="blue", alpha=0.2) +
   geom_density(aes(y[2]), color="red", alpha=0.2) +
   geom_density(aes(y[3]), color="yellow", alpha=0.2) +
   geom_density(aes(y[4]), color="green", alpha=0.2)
 
  #y.plot <- ggplot(y.df)

  #for (i in amostras)
  #{
    #y.plot <- y.plot + geom_density(aes(y[i]), alpha=0.2)
  #}

  ggsave("stat.pdf")
}

gerar.normal()
