list.of.packages <- c("maptools", "spgwr", "spdep", "progress")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library("maptools")
library("spgwr")
library("spdep")
library("progress")


######Define o Arquivo shp####
arquivos <- list.files()

shp <- arquivos[grepl("shp", arquivos)]
poligonos <- readShapePoly(shp)
df_shp <- as.data.frame(poligonos)
coords <- cbind(df_shp$X_COORD, df_shp$Y_COORD)

#####Define apenas as variaveis usadas####
df_shp <- df_shp[,c("AREA" ,"INDICE95","GINI_91","POP_94","POP_RUR","POP_URB"
                       ,"POP_FEM", "POP_MAS", "POP_TOT", "URBLEVEL", "PIB_PC")]
#####Define qual a variavel y######
variavel_y <- "INDICE95"

#######Inicio do programa########
nomes <- names(df_shp)

####### configurações gerais para gwr e sar########
colnames(coords) <- c("X","Y")
SST <- sum((df_shp[,variavel_y] - mean(df_shp[,variavel_y]))^2)
df_rquadrado_gw <- data.frame()

print("Esse programa demora um pouco pois o GWR faz muitos calculos, Entao sente e aprecie a vida.")

##### For para todas as variaveis
for (nome in nomes) {
  print(paste0("comecei a fazer o ", nome))
  if (is.numeric(df_shp[,nome])){
    dataframe <- data.frame(x = df_shp[,variavel_y], y = df_shp[, nome])
    
    #####regressao linear####
    lm.shp <- lm(x ~ y, data = dataframe)
    print(paste0("A RegLin do ", nome," foi feito"))
    
    ###Saida regressao Linear
    rquad <-  summary(lm.shp)$r.squared
    
    ###Criando o texto da funcao linear
    funcao <- paste0("y = ",lm.shp$coefficients[1],"x + ",lm.shp$coefficients[2])
    
    ####definicao do gauss
    print(paste0("Comecei a fazer GWR do ", nome))
    bwGauss <- gwr.sel(x ~ y, data=dataframe, coords=coords, adapt=TRUE, method="aic",
                       gweight=gwr.Gauss, verbose=FALSE)
    
    #####regressao GWR
    gwr.ap <- gwr(x ~ y,data=dataframe,coords=coords,bandwidth=bwGauss,
                  gweight=gwr.Gauss,adapt=bwGauss,hatmatrix=TRUE)
    GWR_SSE <- gwr.ap$results$rss
    GWR_AIC <- gwr.ap$results$AICh
    print(paste0("O GWR do ", nome," foi feito"))
    
    ##### R2 do gwr
    r2_GWR <- 1 - (GWR_SSE/SST)
    nome_col <- nome
    kGauss <- round(bwGauss * length(df_shp[,variavel_y]))
    
    myknn <- knearneigh(coords,k=kGauss,longlat=FALSE,RANN=FALSE)
    mynb <- knn2nb(myknn,sym=TRUE)
    mylistw <- nb2listw(mynb,style="W")
    
    #### inicio do SARK
    print(paste0("Comecei a fazer SARK do ", nome))
    sarK.ap <- lagsarlm(x ~ y,data=dataframe , mylistw, method="Matrix")
    SARk_SSE <- sarK.ap$SSE
    SARk_AIC <- sarK.ap$AIC_lm.model
    
    print(paste0("O SARK do ", nome," foi feito"))
    
    #### r2 do sar
    r2_SARk <- 1 - (SARk_SSE/SST)
    
    mynb <- poly2nb(poligonos)
    mylistw <- nb2listw(mynb,style="W")
    
    ### inicio do SAR
    print(paste0("Comecei a fazer SAR do ", nome))
    sar.ap <- lagsarlm(x ~ y,data=dataframe, mylistw, method="Matrix")
    print(paste0("O SAR do ", nome," foi feito"))
    
    # r2 do SAR
    SAR_SSE <- sar.ap$SSE
    SAR_AIC <- sar.ap$AIC_lm.model
    r2_SAR <- 1 - (SAR_SSE/SST)
    r2_SAR

    df_rquadrado_gw <- plyr::rbind.fill(df_rquadrado_gw, data.frame(nomes = nome_col,
                                        r2_GWR = r2_GWR,
                                        AIC_GWR = GWR_AIC,
                                        r2_SARk = r2_SARk, 
                                        AIC_SARk = SARk_AIC, 
                                        r2_SAR = r2_SAR, 
                                        AIC_SAR = SAR_AIC, 
                                        r2_regLin = round(rquad, 4), func = funcao))
    print(paste0("Terminei o ", nome))
    print(paste0("Os varoles abaixos sao os r2 do GWR do ",nome))
    print(summary(gwr.ap$SDF$localR2))
  }  
}

  df_rquadrado_gw
  
  ######################## EXERCICIO EXTRA ###################################################
  lm.shp <- step(lm(INDICE95 ~ ., data = df_shp))
  nomes <- names(lm.shp$model)
  
  df_extra <- df_shp[,nomes]
  lm.shp <- lm(INDICE95 ~ ., data = df_extra)
  
  sar.ap <- lagsarlm(INDICE95 ~ ., data = df_extra, mylistw)
  
  gwr.ap <- gwr(INDICE95 ~ ., data = df_extra,coords=coords,bandwidth=bwGauss,
                gweight=gwr.Gauss,adapt=bwGauss,hatmatrix=TRUE)
  
  SAR_SSE <- sar.ap$SSE
  r2_SAR <- 1 - (SAR_SSE/SST)
  r2_SAR
  
  