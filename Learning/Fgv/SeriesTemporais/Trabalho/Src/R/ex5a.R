SeriePIBTRI = read.csv2("PIBTRI.csv")
SeriePIBTRISeries = ts(SeriePIBTRI$PIB, frequency = 4)
plot.ts(SeriePIBTRISeries)
