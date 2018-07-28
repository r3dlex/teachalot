library(ggplot2)
library(cowplot)

BaseHist = ggplot(data = SerieDados) +
            ylab("Quantidade") +
            xlab("Valor")

VALE5Hist = BaseHist + geom_histogram(aes(VALE5)) + ggtitle("VALE5")
GOLL4Hist = BaseHist + geom_histogram(aes(GOLL4)) + ggtitle("GOLL4")
AMBV4Hist = BaseHist + geom_histogram(aes(AMBV4)) + ggtitle("AMBV4")
ITUB4Hist = BaseHist + geom_histogram(aes(ITUB4)) + ggtitle("ITUB4")
BBDC4Hist = BaseHist + geom_histogram(aes(BBDC4)) + ggtitle("BBDC4")
BVMF3Hist = BaseHist + geom_histogram(aes(BVMF3)) + ggtitle("BVMF3")
RAPT4Hist = BaseHist + geom_histogram(aes(RAPT4)) + ggtitle("RAPT4")
MYPK3Hist = BaseHist + geom_histogram(aes(MYPK3)) + ggtitle("MYPK3")
GOAU4Hist = BaseHist + geom_histogram(aes(GOAU4)) + ggtitle("GOAU4")
LLXL3Hist = BaseHist + geom_histogram(aes(LLXL3)) + ggtitle("LLXL3")
CSAN3Hist = BaseHist + geom_histogram(aes(CSAN3)) + ggtitle("CSAN3")
DÓLARHist = BaseHist + geom_histogram(aes(DÓLAR)) + ggtitle("DÓLAR")

plot_grid(VALE5Hist, GOLL4Hist, AMBV4Hist,
          ITUB4Hist, BBDC4Hist, BVMF3Hist,
          RAPT4Hist, MYPK3Hist, GOAU4Hist,
          LLXL3Hist, CSAN3Hist, DÓLARHist,
          ncol = 3, nrow = 4)
