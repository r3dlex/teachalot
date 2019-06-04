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
    "dplyr",
    "ggplot2"
  )
)

aCol <- c(0.006, 0.028, 0.035, 0.014, 0.026, 0.032, 0.028, 0.01, 0.02, 0.026)
bCol <- c(0.089, 0.056, 0.04, 0.045, 0.029, 0.056, 0.03, 0.006, 0.034, 0.038)
cCol <- c(0.004, 0.012, 0.015, 0.017, 0.008, 0.018, 0.021, 0.03, 0.013, 0.017)

p <- cbind(a = aCol, b = bCol, c = cCol)

# A
returns <- diff(p)/lag(p, k = 1)[-1,]
returnsMeans <- returns %>% colMeans
wallet <- cbind(0.5, 0.35, 0.15)
roi <- (returnsMeans * wallet * 100) %>% sum

sprintf(
    "ROI = %s", roi
) %>% print

# B
returnsVar <- returns %>% var
returnsCov <- returns %>% cov

# C
# Risco X Retorno de papeis isolados.
returnsStd <- returnsCov %>% diag %>% sqrt
returnRisk <- cbind(returnsMeans,returnsStd)
returnRiskDf <- data.frame(returnRisk)
ativos <- rownames(returnRiskDf)
returnRisk.condicao <- data.frame(matrix("Individual", nrow = nrow(returnRisk)))
returnRiskDf <- cbind(returnRisk.condicao, ativos, returnRiskDf)
rownames(returnRiskDf) <- NULL
names(returnRiskDf)[1] <- paste("condition")
names(returnRiskDf)[2] <- paste("wallet")
names(returnRiskDf)[3] <- paste("return")
names(returnRiskDf)[4] <- paste("return_std")
head(returnRiskDf)
sapply(returnRiskDf, class)

ggplot(data = returnRiskDf, aes(x = return_std, y = return)) +
    geom_point(data = returnRiskDf, colour = "blue") +
    geom_text(data = returnRiskDf,aes(label=wallet), hjust=0, vjust=0, colour = "blue") +
    ggtitle("Risco X Retorno") + 
    labs(x = "Risco (Desvio-padrão)", y = "Retorno Esperado")