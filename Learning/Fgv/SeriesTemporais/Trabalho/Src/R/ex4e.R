x = arima.sim(n=100, list(order=c(0,0,1), ma=c(-0.6)))
plot.ts(x)
acf(x)
pacf(x)
