###################################
#Disciplina: Geoanalise FGV       #
#Alunos:                          #
# Andre Ferreira Bem Silva        #
# Augusto Gonçalves               #
###################################

library(tmap)

#Exercicio Bonus (7)
#Setar o diretorio manualmente
setwd("~/Workspace/geoAnaliseComparativodemodelos/")
crimeShape <- readShapePoly("crime_mg.shp")
crimeDataFrame <- as.data.frame(crimeShape)

# Usamos o URBLEVEL para colorir o mapa
nome <- "URBLEVEL"
if (is.numeric(crimeDataFrame[,nome])){
  dataFrame <- data.frame(x = crimeDataFrame[,variavel_y], y = crimeDataFrame[, nome])
  
  #####regressao linear####
  crimeShapeRegression <- lm(x ~ y, data = dataFrame)
  
  ###Saida regressao Linear
  rSquare <-  summary(crimeShapeRegression)$r.squared
  
  ###Criando o texto da funcao linear
  equation <- paste0("y = ",crimeShapeRegression$coefficients[1],"x + ",crimeShapeRegression$coefficients[2])
  
  ####definicao do gauss
  bwGauss <- gwr.sel(x ~ y, data=dataFrame, coords=coords, adapt=TRUE, method="aic",
                     gweight=gwr.Gauss, verbose=FALSE)
  
  #####regressao GWR
  gwrAp <- gwr(x ~ y,
               data=dataFrame,coords=coords,bandwidth=bwGauss,
               gweight=gwr.Gauss,
               adapt=bwGauss,
               hatmatrix=TRUE)
  
  gwrSse <- gwrAp$results$rss
  gwrAic <- gwrAp$results$AICh
  print(paste0("O GWR do ", nome," foi feito"))
  
  ##### R2 do gwr
  r2Gwr <- 1 - (gwrSse/sst)
  columnName <- nome
  kGauss <- round(bwGauss * length(crimeDataFrame[,variavel_y]))
  
  myknn <- knearneigh(coords,k=kGauss,longlat=FALSE,RANN=FALSE)
  mynb <- knn2nb(myknn,sym=TRUE)
  mylistw <- nb2listw(mynb,style="W")
  
  #### inicio do SARK
  print(paste0("Comecei a fazer SARK do ", nome))
  sarKap <- lagsarlm(x ~ y,data=dataFrame , mylistw, method="Matrix")
  sarkSse <- sarKap$SSE
  sarkAic <- sarKap$AIC_lm.model
  
  print(paste0("O SARK do ", nome," foi feito"))
  
  #### r2 do sar
  r2Sark <- 1 - (sarkSse/sst)
  
  mynb <- poly2nb(poligonos)
  mylistw <- nb2listw(mynb,style="W")
  
  ### inicio do SAR
  print(paste0("Comecei a fazer SAR do ", nome))
  sar.ap <- lagsarlm(x ~ y,data=dataFrame, mylistw, method="Matrix")
  print(paste0("O SAR do ", nome," foi feito"))
  
  # r2 do SAR
  sarSse <- sar.ap$SSE
  sarAic <- sar.ap$AIC_lm.model
  r2Sar <- 1 - (sarSse/sst)
  r2Sar
  
  rSquareGwDataFrame <- plyr::rbind.fill(rSquareGwDataFrame, data.frame(nomes = columnName,
                                                                        r2_GWR = r2Gwr,
                                                                  AIC_GWR = gwrAic,
                                                                  r2_SARk = r2Sark, 
                                                                  AIC_SARk = sarkAic, 
                                                                  r2_SAR = r2Sar, 
                                                                  AIC_SAR = sarAic, 
                                                                  r2_regLin = round(rSquare, 4), func = equation))
  print(summary(gwrAp$SDF$localR2))
}  

crimeShape$R2 <- gwrAp$SDF$localR2
threshold <- quantile(crimeShape$R2)[[3]]
crimeShape$INDICE95_THRESH <- crimeShape$INDICE95
crimeShape$INDICE95_THRESH[crimeShape$R2 < threshold] = 0

#mapas lado a lado 
map <- tm_shape(crimeShape) +
  tm_fill(col = "URBLEVEL", palette = "RdYlGn", 
          style = "quantile",
          title = expression("Urbanização")) +
  tm_layout(legend.position = "top", legend.bg.alpha = 0.5) +
  tm_shape(crimeShape) + 
  tm_borders() +
  tm_grid(projection="longlat", labels.size = .5) +
  tm_compass(position = c(.82, .1), color.light = "grey90") +
  
  tm_bubbles("INDICE95_THRESH", 
             style = "pretty",
             alpha = .6,
             scale = .8,
             col = "red",
             perceptual = TRUE,
             title.size="Índice de Crimes (1995)") +
  tm_style_classic(inner.margins=c(.04,.03, .02, .01), 
                   legend.position = c("left", "top"), 
                   legend.frame = TRUE, 
                   bg.color="lightblue", 
                   legend.bg.color="lightblue", 
                   earth.boundary = TRUE, 
                   space.color="grey90")

# Saves output maps
save_tmap(map, "Mapa-Exercicio7.pdf", dpi = 600)
save_tmap(map, "Mapa-Exercicio7.png", dpi = 300)