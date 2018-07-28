SeriePIBPrev = ts(SeriePIBTRI[45:95,]$PIB, frequency = 4)

y = arima(SeriePIBPrev, order = c(1,1,0))

predict(y, 2)

#$pred
       #Qtr1 Qtr2 Qtr3     Qtr4
#13                    169.1554
#14 169.1714                   

#$se
       #Qtr1 Qtr2 Qtr3     Qtr4
#13                    4.398508
#14 5.801904    
