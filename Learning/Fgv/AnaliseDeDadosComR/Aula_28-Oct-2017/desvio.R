desvio.vetor <- function(x)
{
  media <- mean(x)
  y <- x - media
  z <- (y)^2
  variancia <- sum(z) / (length(x) - 1)

  return (sqrt(variancia))
}

sse.loop <- function(x, u)
{
  print(x)
  y <- c()

  for (i in 1:length(x))
  {
    y <- c(y, (x[i] - u)^2)
  }

  return (soma.loop(y))
}

soma.loop <- function(x)
{
  s <- 0

  for (i in 1:length(x))
  {
    s <- s + x[i]
  }

  return (s)
}

media.loop <- function(x)
{
  return (soma.loop(x) / length(x))
}

desvio.loop <- function(x)
{
  n <- length(x)

  if (n <= 1)
  {
    return (NULL)
  }

  media <- media.loop(x)
  y <- sse.loop(x, media)
  variancia <- y / (n - 1)

  return (sqrt(variancia))
}

#Teste feito em aula
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
t <- desvio.vetor(x * 3)
sprintf("Resultado do professor: %f", t)

#Deve dar o mesmo resultado que a versao com vetor
t2 <- desvio.loop(x * 3)
sprintf("Resultado do for: %f", t2)
