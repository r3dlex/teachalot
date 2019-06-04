mbas <- read.csv("mba_salaries.csv")

salary.constants.unemployed <- 0
salary.constants.didnanswer <- 998
salary.constants.didntdisclose <- 999

salary.mask.unemployed <- mbas$salary == salary.constants.unemployed
salary.mask.didntanswer <- mbas$salary == salary.constants.didntanswer
salary.mask.didntdisclose <- mbas$salary == salary.constants.didntdisclose

mbas.valids <- mba_salaries[mbas$salary != salary.constants.unemployed & mbas$salary != salary.constants.didntanswer & mbas$salary != salary.constants.didntdisclose,]

