###############################################
# This is the script file for the


package.requirements <- c("ggplot2", "dplyr", "kableExtra",
                          "tables", "Hmisc", "data.table", 
                          "corrplot", "gmodels", "rpart",
                          "rpart.plot", "arules", "car")

# Uncomment this line if you want to install all the requirements
# install.packages(package.requirements)

# Loads all libraries
lapply(package.requirements, library, character.only = TRUE)

# Used in the construction of the Decision Tree and anywhere
# that a random variable is applicable
set.seed(5668)


source.directory <- "Src"
data.directory <- "Data"
gen.directory <- "Gen"
image.directory <- sprintf("%s/%s", gen.directory, "Img")
gentable.directory <- sprintf("%s/%s", gen.directory, "Table")

GenerateDirectory <- function(dirname)
{
  dir.create(file.path(".", dirname), showWarnings = FALSE)
}

GenerateDirectories <- function()
{
  sapply(c(gen.directory, image.directory, gentable.directory), GenerateDirectory)
}

# Defines manual colors for the STATUS variable
status.colors <- c("#B0D5DB", "#E46161")

GetDataFilepath <- function(filename)
{
  return (sprintf("%s/%s", data.directory, filename))
}

GetSrcFilepath <- function(filename)
{
  return (sprintf("%s/%s", source.directory, filename))
}

GetImgFilepath <- function(filename)
{
  return (sprintf("%s/%s", image.directory, filename))
}

GetLatexTableFilepath <- function(filename)
{
  return (sprintf("%s/%s", gentable.directory, filename))
}

ReadDataFrameFromFilepath <- function(filename)
{
  return (fread(GetDataFilepath(filename), header=T, sep=";"))
}

RunSrcFromPath <- function(filename)
{
  source(GetSrcFilepath(filename))
}

SaveGgplot <- function(filename)
{
  return (ggsave(GetImgFilepath(filename)))
}


GenerateStatusPlot <- function(calvo.df)
{
  bp <- ggplot(calvo, aes(x=calvo$STATUS)) +
    geom_bar(aes(y = ..count.. / sum(..count..), fill = STATUS), stat="count", position = position_dodge()) +
    geom_text(aes(label = scales::percent(..count.. / sum(..count..)), y=  ..count.. / sum(..count..) ), stat= "count", position = position_dodge(width = 1), vjust = -0.5) +
		scale_fill_manual(values = status.colors) + 
    scale_y_continuous(labels = scales::percent) + 
    labs(y = "Frequência Relativa (%)", x = "STATUS")

  print(bp)
  SaveGgplot("status_freq.pdf")

  return (bp)
}

GenerateNaturezaStatusPlot <- function(calvo.df)
{
  natxstatus.df <- data.frame(calvo.df$NATUREZA, calvo.df$STATUS)
  names(natxstatus.df) <- c("NATUREZA", "STATUS")
  natxstatus.df <- within(natxstatus.df, NATUREZA <- factor(NATUREZA, levels=names(sort(table(NATUREZA), decreasing=FALSE))))

	bp <- ggplot(natxstatus.df, aes(NATUREZA, group = factor(STATUS, levels = rev(levels(STATUS))))) + 
		geom_bar(aes(y = (..prop..), fill = STATUS), stat = "count", position = position_dodge()) +
		geom_text(aes(label = scales::percent(..prop..), y= ..prop.. ), stat= "count", position = position_dodge(width = 1)) +
		scale_fill_manual(values = status.colors) + 
		scale_y_continuous(labels = scales::percent) + 
		labs(y = "Frequência Relativa (%)", x = "NATUREZA") +
		coord_flip() +
		theme(legend.position = "top")

  print(bp)
  SaveGgplot("natureza_vs_status.pdf")

  return (bp)
}

#pdf(sprintf('Img/%s.pdf', 'final_agelabel'),width=10,height=7,paper='special')
#print(ggpairs(mba.df.final, aes(color = agelabel)))
#dev.off()

#GenerateStatusCharts <- function(calvo.df)
#{
  #pie(table(calvo$STATUS))
#}

#ecxsts.chisq <- chisq.test(calvo$ESTCIV, calvo$STATUS)
#corrplot(
    #ecxst.chisq$observed,
    #is.corr = FALSE,
    #method="square",
    #tl.col = "#000000",
    #tl.srt = 45,
    #tl.cex = .9,
    #number.cex = .8,
    #mar = c(0,0,2,0),
    #addCoefasPercent = TRUE,
    #cl.align.text = "l"
#)

CreateFaixaRendaCategory <- function(calvo.df)
{
  calvo.df$FAIXARENDA = ''
  calvo.df[calvo.df$RENDA >= 1 & calvo.df$RENDA <= 1000,]$FAIXARENDA = '1a1000'
  calvo.df[calvo.df$RENDA >= 1001 & calvo.df$RENDA <= 5000,]$FAIXARENDA = '1001a5000'
  calvo.df[calvo.df$RENDA >= 5001 & calvo.df$RENDA <= 10000,]$FAIXARENDA = '5001a10000'
  calvo.df[calvo.df$RENDA >= 10001 & calvo.df$RENDA <= 50000,]$FAIXARENDA = '10001a50000'
  calvo.df[calvo.df$RENDA >= 50001 & calvo.df$RENDA <= 200000,]$FAIXARENDA = '50001a200000'
  calvo.df[calvo.df$RENDA >= 200001 & calvo.df$RENDA <= 500000,]$FAIXARENDA = '200001a500000'
  calvo.df[calvo.df$RENDA >= 500001,]$FAIXARENDA = '>500001'

  return (calvo.df)
}

NormalizeCalvoDataFrame <- function(calvo.df)
{
  calvo.df$UF = factor(calvo.df$UF)

  return (calvo.df)
}

WriteTableToLatex <- function(atable, filename)
{
  text.out <- capture.output(latex(atable))
  #Localization to pt-BR
  text.out <- gsub("Percent", "Porcentagem", x = text.out)
  text.out <- gsub("All", "Total", x = text.out)
  #Writes tex to output file
  write(text.out, file=GetLatexTableFilepath(filename), sep = "\n")

  return (text.out)
}

CreateStatusNaturezaTable <- function(calvo.df)
{
  sn.df <- data.frame(factor(calvo$STATUS), factor(calvo$NATUREZA))
  names(sn.df) <- c("STATUS", "NATUREZA")
  sntable <- tabular((Natureza=NATUREZA) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data=sn.df)
  WriteTableToLatex(sntable, "status_natureza.tex")
}

CreateStatusEstadoCivilTable <- function(calvo.df)
{
  se.df <- data.frame(factor(calvo$STATUS), factor(calvo$ESTCIV))
  names(se.df) <- c("STATUS", "ESTCIV")
  setable <- tabular((EstadoCivil=ESTCIV) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data = se.df)
  WriteTableToLatex(setable, "status_estciv.tex")
}

CreateStatusEscolaridadeTable <- function(calvo.df)
{
  se.df <- data.frame(factor(calvo$STATUS), factor(calvo$ESCOLARIDADE))
  names(se.df) <- c("STATUS", "ESCOLARIDADE")
  setable <- tabular((Escolaridade=ESCOLARIDADE) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data = se.df)
  WriteTableToLatex(setable, "status_escolaridade.tex")
}

CreateStatusUfTable <- function(calvo.df)
{
  su.df <- data.frame(factor(calvo$STATUS), factor(calvo$UF))
  names(su.df) <- c("STATUS", "UF")
  setable <- tabular((Estado=UF) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data = su.df)
  WriteTableToLatex(setable, "status_estado.tex")
}

CreateStatusTable <- function(calvo.df)
{
  s.df <- data.frame(factor(calvo.df$STATUS))
  names(s.df) <- "STATUS"
  stable <- tabular((Status=s.df$STATUS) + Hline() + 1 ~ (Percent("col") + 1))
  WriteTableToLatex(stable, "status.tex")
}


# Generates output directories if they are not created
GenerateDirectories()

#conn <- odbcConnectExcel2007("dados.xlsx")
#calvo <- sqlFetch(conn, "CALVOshrt")
#odbcClose(conn)
calvo <- ReadDataFrameFromFilepath("Calvo.csv")
calvo <- NormalizeCalvoDataFrame(calvo)

# Initial analysis plots
GenerateStatusPlot(calvo)
GenerateNaturezaStatusPlot(calvo)
# Tables
CreateStatusTable(calvo)
CreateStatusNaturezaTable(calvo)
CreateStatusEstadoCivilTable(calvo)
CreateStatusEscolaridadeTable(calvo)
CreateStatusUfTable(calvo)
# Correlation plots

#analisar variávies
#Status
#CrossTable(calvo$STATUS)
#UF
#CrossTable(calvo$UF, calvo$STATUS, prop.chisq = F, prop.t = F, digits = 2)
#Escolaridade
#CrossTable(calvo$ESCOLARIDADE, calvo$STATUS, prop.chisq = F, prop.t = F, digits = 2)
#Estado Civil
#CrossTable(calvo$ESTCIV, calvo$STATUS, prop.chisq = F, prop.t = F, digits = 2)

pie(table(calvo$STATUS))

#Renda
min(calvo$RENDA)
max(calvo$RENDA)

ksalario=discretize(calvo$RENDA, method = 'frequency', categories=5)

prop.table(table(ksalario, calvo$STATUS), 1)

CreateFaixaRendaCategory(calvo)

calvo$FAIXARENDA = ksalario

calvo

head(calvo$NATUREZA)

CrossTable(calvo$FAIXARENDA, calvo$STATUS, prop.chisq = F, prop.t = F, digits = 2)

#hist(calvo$FAIXARENDA)

#Natureza
CrossTable(calvo$NATUREZA, calvo$STATUS, prop.chisq = F, prop.t = F, digits = 2)
table(calvo$NATUREZA, calvo$FAIXARENDA)

#boxplot(calvo$RENDA, calvo$NATUREZA)

anova <- aov(calvo$RENDA ~ calvo$NATUREZA)
summary(anova)

flag=sample(1:25000, 12500, replace = F)

calvo.lrn = droplevels(calvo[flag,])
calvo.tst = droplevels(calvo[-flag,])

prop.table(table(calvo.lrn$STATUS)); prop.table(table(calvo.tst$STATUS))

#Arvore
ac1 = rpart(data = calvo.lrn, STATUS~UF+ESCOLARIDADE+ESTCIV+FAIXARENDA+NATUREZA)
prp(ac1, type=2, extra=104,nn=T, fallen.leaves = F, branch.col = "red", branch.lty = 5,box.col = c("white",'green'))
prp(ac1, type=1, extra=104, fallen.leaves = FALSE, branch.type = 1, faclen = 30)
ac1
print(ac1, digits = 2)
printcp(ac1)

#Teste
ac2 = rpart(data = calvo.tst, STATUS~UF+ESCOLARIDADE+ESTCIV+FAIXARENDA+NATUREZA)
prp(ac2, type=2, extra=104,nn=T, fallen.leaves = F, branch.col = "red", branch.lty = 5,box.col = c("white",'green'))
prob = predict(ac2, newdata = calvo.tst, type = "prob")
head(prob)

#Probabilidade
print("Yupieeee")
phat_tst = predict(ac1, newdata = calvo.tst, type = "prob", se.fit = FALSE)
print("Jero")
phat_tst
print("noo")
yhat_tst = predict(ac1, newdata = calvo.tst, type = "class", se.fit = FALSE)
print("Ha")

print("Woohoo")
CrossTable(calvo.tst$STATUS, yhat_tst, prop.chisq = F, prop.t = F, digits = 2)
#####################

calvo[calvo$FAIXARENDA == '',]

mean(calvo$RENDA)
sd(calvo$RENDA)
(sd(calvo$RENDA) * 2) - mean(calvo$RENDA)
mean(calvo$RENDA) + (sd(calvo$RENDA) * 2)

calvo2 <- calvo[calvo$RENDA <= mean(calvo$RENDA) + (sd(calvo$RENDA) * 2),]
mean(calvo2$RENDA)
sd(calvo2$RENDA)

sd(calvo2$RENDA) - mean(calvo2$RENDA)

calvo3 <- calvo2[calvo2$RENDA >= sd(calvo2$RENDA) - mean(calvo2$RENDA),]

boxplot(calvo3$RENDA)
hist(calvo3$RENDA)

