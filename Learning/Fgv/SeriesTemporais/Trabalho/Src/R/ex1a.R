library(tseries)
library(xts)
library(tidyverse)
library(magrittr)
library(forecast)
library(TTR)

kGenImgPath <- "./Gen/Image"

setwd("/home/andre/Workspace/teachalot/Learning/Fgv/SeriesTemporais/Trabalho")

GetImagePath <- function(name) {
  paste0(kGenImgPath, "/", name)
}

# Trata os dados de entrada
seriesDeDados <- read.csv("./Data/SeriesDeDados.csv")
seriesDeDados[, 2:13] <- sapply(
                                seriesDeDados[,2:13], function (x) {
                                  x=as.numeric(levels(x))[x] 
                                })
seriesDeDados$DATA <- as.Date(seriesDeDados$DATA, "%d/%m/%Y")
dadosSemData <- seriesDeDados[, 2:13]

set.seed(1)

FuncaoTemporal1a <- function(x2, x1) {
  log(x2 / x1)
}

Funcao1a <- function(x) {
  ret <- NULL
  
  for (i in 1:length(x)) {
    ret[i] <- FuncaoTemporal1a(x[i+1], x[i])
  }
  
  return(ret)
}

matriz1a <- apply(dadosSemData, 2, Funcao1a)
matriz1a <- as.data.frame(head(matriz1a, -1))
media1a <- apply(matriz1a, 2, mean)
