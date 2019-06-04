sAleatoria = arima.sim(n = 200, list(ma = -0.6))
plot.ts(sAleatoria,xlab='tempo',ylab='observacoes')
acf(sAleatoria,main='ACF',xlab='defasagem',ylab='autocorrelacoes')
pacf(sAleatoria,main='PACF',xlab='defasagem',ylab='autocorrelacoes')
