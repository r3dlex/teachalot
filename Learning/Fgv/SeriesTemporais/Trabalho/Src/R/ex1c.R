graphics.off()
par(mfrow = c(4,6), mar=c(3,2,3,1))

for (x in c(2:13)){
  acf(get(paste(colnames(SerieDados)[x], "Series", sep = "")), 
      main = paste("ACF", colnames(SerieDados)[x]))
  pacf(get(paste(colnames(SerieDados)[x], "Series", sep = "")),
       main = paste("PACF", colnames(SerieDados)[x]))
}
