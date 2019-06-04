library(tidyr)

#Fixes multiple values in same columns from tidyr samples
spread(table2, key=type, value=count)
gather(table4a, "1999", "2000", key="year", value="cases")
separate(table3, rate, into = c("cases", "population"), sep = "/")
