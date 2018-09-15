library(igraph)
library(ggplot2)
library(ggdendro)
library(network)
library(sna)
#library(rgl)
library(readxl)
library(tidyverse)

m2 <- gplot(matrix_twomode,gmode="twomode",  displaylabels = TRUE, edge.col="gray",label.cex = 0.7,usearrows=FALSE)

#### Trabalhando com base de dados da rede two mode.
## Importar dados Rede.R  
twomode <- read_excel("r2.xlsx")
twView(twomode)


## Transformar data.frame em matrix 
twomode2 = twomode[,-1]
rownames(twomode2) <- c("João","Maria","José","Paulo","Pedro","Luisa","Marcelo","Alfredo","Joaquim",
                        "Gabriela","Flávia","Catapulto","Rodrigo","Gabriel","Rodolfo")
matrix_twomode = as.matrix(twomode2)
matrix_twomode

g2m <- graph_from_incidence_matrix(matrix_twomode)

-V(g2m)$color <- c("tomato","steelblue")[V(g2m)$type+1]
V(g2m)$shape <- c("circle","square")[V(g2m)$type+1]

V(g2m)$label.cex=.6
V(g2m)$label.font=2


## Plotar a rede 
## aqui deve-se ajustar o layout manualmente
## as coordenadas ficar?o salvas em m2

m2 <- gplot(matrix_twomode,gmode="twomode",  displaylabels = TRUE, edge.col="gray",label.cex = 0.7,usearrows=FALSE,  interactive = TRUE)

png("twomode1.png", 750, 750, type='cairo')
# Aprimorando a representa??o da rede
gplot(matrix_twomode, gmode="twomode",
      displaylabels = TRUE,
      edge.col="gray",
      vertex.col = c("tomato", "tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","tomato","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue"),
      
      label.cex = 1.3,
      usearrows=FALSE,
      vertex.cex = closeness(matrix_twomode,gmode="twomode")*4, 
      coord = m2)
dev.off()

# Calcular Centralidade de Grau (degree), Centralidade de Proximidade (closeness) e Centralidade de Intermedia??o
d4 = degree(matrix_twomode,gmode="twomode",cmode="indegree")
c4 = closeness(matrix_twomode,gmode="twomode")
b4 = betweenness(matrix_twomode,gmode="twomode")
centralidade4 = t(rbind(d4,c4,b4))
rownames(centralidade4) = c("Jo?o","Maria","Jos?","Paulo","Pedro","Luisa","Marcelo","Alfredo","Joaquim",
                            "Gabriela","Fl?via","Catapulto","Rodrigo","Gabriel","Rodolfo","iPhone","iPad","Livro Harry Potter",
                            "jogo MineCraft","Camisa do Corinthians","Bola de Futebol","Flauta Transversal","Lista Telef?nica",
                            "Caixa de F?sforos","Calculadora","Detergente")
colnames(centralidade4) = c("Degree","Closeness","Betweenness") 
centralidade4

## An?lise da Rede Two Mode: 
# Camisa do Corinthians ? o produto que possui mais la?os com as pessoas, mais proximidade e mais intermedia??es.
# Detergente ? o produto com menor la?o, menor proximidade e com poucas intermedia??es. Seria um produto candidato a sair da rede.
# J? em rela??o as pessoas, Maria ? a que possui mais la?o (11 produtos), ? a pessoa-chave para receber divulga??o de novos produtos.


#### Desafio 
# Implementar o algoritmo hier?rquico e apresenta o dendrograma de Pessoas
pessoas = hclust(dist(matrix_twomode), "average") 
pess = ggdendrogram(pessoas, rotate=FALSE)
pess_data = dendro_data(pessoas)
ggdendrogram(pess_data, rotate=TRUE, size=2) + labs(title="Dendrograma das Pessoas")


# Implementar o algoritmo hier?rquico e apresenta o dendrograma de produtos, transpondo a matrix
t_matrix_twomode = t(matrix_twomode) 
produto = hclust(dist(t_matrix_twomode), "average")  
prod <- ggdendrogram(produto, rotate=FALSE)
prod_data <- dendro_data(produto)
ggdendrogram(prod_data, rotate=TRUE, size=2) + labs(title="Dendrograma dos Produtos")


# Cortando a ?rvore de produtos em 3 grupos
grupos <- cutree(produto,k=3)
grupos

usuarios <- rep(0,15)
grupos <- c(usuarios, grupos)

V(g2m)$grupo <- grupos



#colorindo o grafo
V(g2m)$cor=V(g2m)$grupo 
V(g2m)$cor=gsub(0,"grey80",V(g2m)$cor) 
V(g2m)$cor=gsub(1,"tomato",V(g2m)$cor)
V(g2m)$cor=gsub(2,"steelblue",V(g2m)$cor)
V(g2m)$cor=gsub(3,"orange",V(g2m)$cor)
cores<-V(g2m)$cor

png("twomode2.png", 750, 750, type='cairo')

gplot(matrix_twomode, gmode="twomode",
      displaylabels = TRUE,
      edge.col="gray",
      vertex.col = V(g2m)$cor,
      label.cex = 1.3,
      usearrows=FALSE,
      vertex.cex = closeness(matrix_twomode,gmode="twomode")*4, 
      coord = m2)
dev.off()

net <- network(matrix_twomode,
              matrix.type = "bipartite",
              ignore.eval = FALSE,
              names.eval = "weights")

ggnet2(net, color = "mode", palette = "Set2", size = 0) +
  geom_point(aes(color = color), size = 18, color = "white") +
  geom_point(aes(color = color), size = 18, alpha = 0.5) +
  geom_point(aes(color = color), size = 14) +
  geom_text(aes(label = V(g2m)$name), color = "grey35") +
  guides(color = FALSE)

ggnet2(net, color = "grupo", node.color = grupo, palette = "Set2") +
  geom_point(aes(color = color), size = 18, color = "white") +
  geom_point(aes(color = color), size = 18, alpha = 0.5) +
  geom_point(aes(color = color), size = 14) +
  geom_text(aes(label = V(g2m)$name), color = "grey35") 

