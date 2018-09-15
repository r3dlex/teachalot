library(igraph)
library(ggplot2)
library(ggdendro)
library(network)
library(sna)
#library(rgl)
library(readxl)
library(tidyverse)

set.seed(10)
#### Trabalhando com a base de dados da rede one mode.
## Importar dados Rede.R:  
onemode <- read_excel("r1.xlsx")

## Transformar data.frame em matrix 
onemode2 = onemode[ , -1]
rownames(onemode2) <- c("A","B","C","D","E","F","G","H","I", "J","K", "L","M","N","O","P") 
matrix_onemode = as.matrix(onemode2)
matrix_onemode


## Plotar a rede 
rede_onemode <- graph_from_adjacency_matrix(matrix_onemode, mode = c("undirected"), weighted = NULL, diag=FALSE)

png("g1.png", 1000, 1000, type='cairo')
# om <- plot(rede_onemode, mode= "kamadakawai", vertex.color="gray80", vertex.frame.color= "gray50", vertex.label.cex = 0.7, edge.color = "orange", vertex.label.family= ("cal"))
om <- gplot(matrix_onemode,
            vertex.cex = 1.5,
            vertex.col="gray60", 
            edge.col = "lightblue", 
            usearrows = FALSE, 
            vertex.border = "gray60", 
            displaylabels=TRUE,
            label.cex = 1.2,
            label.pos = 5,
            mode = "kamadakawai"
)
dev.off()


# Calcular Centralidade de Grau (degree), Centralidade de Proximidade (closeness) e Centralidade de Intermedia??o (betweenness)
d = degree(matrix_onemode,gmode="onemode",cmode="indegree")
c = closeness(matrix_onemode,gmode="onemode")
cb = betweenness(matrix_onemode,gmode="onemode")


# Mostrar degree, closeness e betweenness juntos em formato de tabela
centralidade = t(rbind(d,c,b))
rownames(centralidade) <- c("A","B","C","D","E","F","G","H","I", "J","K", "L","M","N","O","P") 
colnames(centralidade) <- c("Degree","Closeness","Betweenness") 
centralidade

dd <- as.data.frame(d)
ggplot(dd, aes(d)) + geom_histogram(binwidth = 1.5)+ labs(x ="Grau", y = "Contagem")


## An?lises da Rede One Mode: 
## K ? o ator que possui o maior n?mero de la?os com outros atores (11 la?os). ? tamb?m o elemento que possui maior proximidade e faz mais intermedia??es que os demais.
## L ? o ator que possui menos la?os (somente com I). Portanto, ? o ator mais distante dos demais e n?o possui intermedia??es.
## Se retirarmos as liga??es de L com I, n?o haver? grandes altera??es na rede.

## Trocar dado LI e IL para zero e plotar a rede 
sem_l_onemode = matrix_onemode
sem_l_onemode[9,12] = sem_l_onemode[9,12]==0
sem_l_onemode[12,9] = sem_l_onemode[12,9]==0
sem_l <- graph_from_adjacency_matrix(sem_l_onemode, mode = c("undirected"), weighted = NULL)

png("g2.png",1000, 1000, type='cairo')

gplot(sem_l_onemode, 
      vertex.cex = 1.5,
      vertex.col="gray60", 
      edge.col = "lightblue", 
      usearrows = FALSE, 
      vertex.border = "gray60", 
      displaylabels=TRUE,
      label.cex = 1.2,
      label.pos = 5, 
      coord = om)

# plot(sem_l, vertex.color="gray80", vertex.frame.color= "gray50", vertex.label.cex = 0.7, edge.color = "orange", vertex.label.family= ("cal"), coord = om)
dev.off()

## Calcular medidas de centralidades sem liga??o com L.
## O resultado da medida de proximidade ficou zerado para todos os atores.
d2 = degree(sem_l_onemode,gmode="onemode",cmode="indegree")
c2 = closeness(sem_l_onemode,gmode="onemode")
b2 = betweenness(sem_l_onemode,gmode="onemode")
centralidade2 = t(rbind(d2,c2,b2))
rownames(centralidade2) = c("A","B","C","D","E","F","G","H","I", "J","K", "L","M","N","O","P") 
colnames(centralidade2) = c("Degree","Closeness","Betweenness") 
centralidade2

dd2 <- as.data.frame(d2)

ggplot(dd2, aes(d2)) + geom_histogram(binwidth = 1.5) + labs(x ="Grau", y = "Contagem")


## Ao retirar K da matrix:
# J apareceu com maior n?mero de la?os (9);
# J e E ficaram os mais pr?ximos dos demais;
# E ficou com mais intermedia??es.
sem_k_onemode = matrix_onemode[-11,-11]
sem_k <- graph_from_adjacency_matrix(sem_k_onemode, mode = c("undirected"), weighted = NULL)

# plot(sem_k, layout= om, vertex.color="gray80", vertex.frame.color= "gray50", vertex.label.cex = 0.7, edge.color = "orange", vertex.label.family= ("cal"))

#exclui o K tamb?m da lista de coordenadas
om<-om[-11,]

png("g3.png", 1000, 1000, type='cairo')
gplot(sem_k_onemode, 
      vertex.cex = 1.5,
      vertex.col="gray80", 
      edge.col = "orange", 
      usearrows = FALSE, 
      vertex.border = "gray80", 
      displaylabels=TRUE,
      label.cex = 1.2,
      label.pos = 5, 
      coord = om)
dev.off()


d3 = degree(sem_k_onemode,gmode="onemode",cmode="indegree")
c3 = closeness(sem_k_onemode,gmode="onemode")
b3 = betweenness(sem_k_onemode,gmode="onemode")
centralidade3 = t(rbind(d3,c3,b3))
rownames(centralidade3) = c("A","B","C","D","E","F","G","H","I", "J","L","M","N","O","P") 
colnames(centralidade3) = c("Degree","Closeness","Betweenness") 
centralidade3

dd3 <- as.data.frame(d3)
ggplot(dd3, aes(d3)) + geom_histogram(binwidth = 1.5) + labs(x ="Grau", y = "Contagem")

#Gera os boxplots dos graus das redes
graus<- as.data.frame(t(rbind(d, d2, d3)))
# graus_s <- gather(graus, "rede", "grau")

ggplot(graus_s, aes(rede, grau)) + geom_boxplot()


## ggnetwork
# ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
#   geom_edges(color = "black") +
#   geom_nodelabel(aes(color = vertex.names, label = LETTERS[ vertex.names ]),
#                  fontface = "bold") +
#   theme_blank()

set.seed(10)
ggplot(ggnetwork(matrix_onemode), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "black") +
  geom_nodelabel(aes(color = vertex.names, label = vertex.names),
                fontface = "bold", label.r=unit(0.2, "lines"), size = 7) +
  theme_blank()

ggplot(ggnetwork(sem_k_onemode), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "black") +
  geom_nodelabel(aes(color = vertex.names, label = vertex.names),
                 fontface = "bold", label.r=unit(0.2, "lines"), size = 7) +
  theme_blank()


ggplot(ggnetwork(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "black") +
  geom_nodelabel(aes(color = vertex.names, label = vertex.names),
                 fontface = "bold", label.r=unit(0.2, "lines"), size = 7) +
  theme_blank()
