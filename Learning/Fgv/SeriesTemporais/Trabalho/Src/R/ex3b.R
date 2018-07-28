#Na minha opinião, não há sazonalidade nesta séries de dados, muito menos flutuações randômicas.

#Decompondo, séries não sazonais (retirando flutuações randômicas para ficar claro a tendência).

#o que pode ser notado é que a Série Original, sem transformação já apresenta uma tendência de alta nos 15 primeiros anos e entra em tendência de queda

plot.ts(skirtDiameterSerie, main = "Série Original")
library("TTR")
skirtDiameterSerieSMA3 = SMA(skirtDiameterSerie, n=3)
