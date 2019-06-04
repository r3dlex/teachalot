uri <- "http://robjhyndman.com/tsdldata/roberts/skirts.dat"
skirtDiameter <- scan(uri, skip = 5)
skirtDiameterTs <- ts(skirtDiameter, start = c(1866), frequency = 1)
