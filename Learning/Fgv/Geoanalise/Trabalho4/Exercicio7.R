#####################################################
# T3FARIA LIMA - GEOANALISE E ESTATISTICA ESPACIAL  #
#               TAREFA AULAS 04 E 05                #  
#####################################################

### EXERCICIO BONUS

# Carregar o mapa que será usado na análise

setwd("C:/Users/Isabela/OneDrive/Pós Graduação/Geoanálise e Estatística Espacial/_Exercícios/Aulas 4 e 5")
crime <- readShapePoly("crime_mg.shp")
plot(crime)

# Conhecendo os dados
View(as.data.frame(crime))

df_crime <- as.data.frame(crime)

summary(df_crime)
hist(df_crime$AREA)
hist(df_crime$INDICE94)
hist(df_crime$INDICE95)
hist(df_crime$GINI_91)
hist(df_crime$POP_94)
hist(df_crime$POP_RUR)
hist(df_crime$POP_URB)
hist(df_crime$POP_FEM)
hist(df_crime$POP_MAS)
hist(df_crime$POP_TOT)
hist(df_crime$URBLEVEL)
hist(df_crime$PIB_PC)

boxplot(df_crime$AREA, main= "Area")
boxplot(df_crime$INDICE94, main= "Indice94")
boxplot(df_crime$INDICE95, main= "Indice95")
boxplot(df_crime$GINI_91, main= "Gini91")
boxplot(df_crime$POP_94, main= "Pop94")
boxplot(df_crime$POP_RUR, main= "Pop Rural")
boxplot(df_crime$POP_URB, main= "Pop Urbana")
boxplot(df_crime$POP_FEM, main= "Pop F")
boxplot(df_crime$POP_MAS, main= "Pop M")
boxplot(df_crime$POP_TOT[df_crime$ID != 62 & df_crime$ID != 190], main= "Pop Total")
boxplot(df_crime$URBLEVEL, main= "Nivel Urbaniz")
boxplot(df_crime$PIB_PC, main= "PIB Per Capita")



mgcrime_gini50 <- ac[ac$GINI_91 >= .5,]
plot(mgcrime_gini50,col="light blue",add=T)

qtm(ac)
qtm(ac, fill="INDICE94", text="iso_a3", text.size="AREA", format="ac", style="yellow", 
    text.root=5, fill.title="Well-Being Index", fill.textNA="Non-European countries")

#mapas lado a lado com evolução da criminalidade
tm_shape(crime) +
  tm_bubbles(size=c("INDICE94", "INDICE95"), 
             title.size="Índice de criminalidade em MG") +
  tm_facets(free.scales=FALSE) +
  tm_layout(panel.labels=c("1994", "1995"))

#mapas lado a lado 
tm_shape(crime) +
  tm_polygons(c("INDICE94", "GINI_91"),
              style=c("pretty", "kmeans"),
              palette=list("RdYlGn", "Blues"),
              auto.palette.mapping=FALSE)+
  tm_layout(panel.labels=c("Criminalidade 1994", "Gini 1991"))
  
