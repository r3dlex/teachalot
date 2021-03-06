###############################################
# This is the script file for the


package.requirements <- c("ggplot2", "dplyr",
                          "tables", "Hmisc", "data.table", 
                          "corrplot", "gmodels", "rpart",
                          "rpart.plot", "arules", "car")

# Uncomment this line if you want to install all the requirements
#install.packages(package.requirements)

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

# Defines manual colors for the STATUS variable - adimpl, inadimpl
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

GenerateRendaPlot <- function(calvo.df)
{
  cut.points <- quantile(calvo.df$RENDA, c(.05, .95))
  sp <- ggplot(calvo.df, aes(x = "", y = RENDA, color = RENDA)) + 
    geom_point(shape=1) + 
    geom_hline(yintercept = cut.points[1], color = "green", linetype = "dashed") +
    geom_hline(yintercept = cut.points[2], color = "green", linetype = "dashed") +
		theme(legend.position = "top")

  print(sp)
  SaveGgplot("renda_original.pdf")

  calvo2.df <- calvo.df %>% filter(RENDA > cut.points[1] & RENDA < cut.points[2])

  sp2 <- ggplot(calvo2.df, aes(x = "", y = RENDA, color = RENDA)) + 
    geom_point(shape = 1) + 
    geom_hline(yintercept = mean(calvo2.df$RENDA) - sd(calvo2.df$RENDA), color = "blue", linetype = "dashed") +
    geom_hline(yintercept = mean(calvo2.df$RENDA) + sd (calvo2.df$RENDA), color = "blue", linetype = "dashed") + 
    geom_hline(yintercept = mean(calvo2.df$RENDA), color = "darkgrey") + 
		theme(legend.position = "top")
  print(sp2)
  SaveGgplot("renda_modified.pdf")

  sp2 <- ggplot(calvo2.df, aes(x = STATUS, y = RENDA, color = RENDA)) + 
    geom_boxplot(fill = status.colors) + 
		scale_fill_manual(values = status.colors) + 
    geom_hline(yintercept = mean(calvo2.df$RENDA) - sd(calvo2.df$RENDA), color = "blue", linetype = "dashed") +
    geom_hline(yintercept = mean(calvo2.df$RENDA) + sd (calvo2.df$RENDA), color = "blue", linetype = "dashed") + 
    geom_hline(yintercept = mean(calvo2.df$RENDA), color = "darkgrey")

  print(sp2)
  SaveGgplot("status_renda_modified.pdf")

  return (sp)
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

NormalizeUfInDataFrame <- function(calvo.df)
{
  calvo.df[calvo.df$UF != "SP" & calvo.df$UF != "MG"]$UF <- "OT"
  calvo.df <- droplevels(calvo.df)
  calvo.df$UF <- factor(calvo.df$UF)

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
  WriteTableToLatex(setable,  "status_estciv.tex")
}

CreateStatusEscolaridadeTable <- function(calvo.df)
{
  se.df <- data.frame(factor(calvo$STATUS), factor(calvo$ESCOLARIDADE))
  names(se.df) <- c("STATUS", "ESCOLARIDADE")
  setable <- tabular((Escolaridade=ESCOLARIDADE) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data = se.df)
  WriteTableToLatex(setable, "status_escolaridade.tex")
}

CreateStatusUfTable <- function(calvo.df, filename)
{
  su.df <- data.frame(factor(calvo$STATUS), factor(calvo$UF))
  names(su.df) <- c("STATUS", "UF")
  setable <- tabular((Estado=UF) + Hline() + 1 ~ (Status=STATUS) * Format(digits = 2) * (Percent("row") + 1), data = su.df)
  WriteTableToLatex(setable, filename)
}

CreateStatusTable <- function(calvo.df)
{
  s.df <- data.frame(factor(calvo.df$STATUS))
  names(s.df) <- "STATUS"
  stable <- tabular((Status=s.df$STATUS) + Hline() + 1 ~ (Percent("col") + 1))
  WriteTableToLatex(stable, "status.tex")
}

CreateTreeTestTable <- function(calvo.df, test.data)
{
  ss.df <- data.frame(factor(calvo.tst$STATUS), factor(as.vector(test.data)))
  names(ss.df) <- c("STATUS_ORIGINAL", "STATUS_PREVISAO")
  sstable <- tabular((Original = STATUS_ORIGINAL) + Hline() + 1 ~ (Previsto = STATUS_PREVISAO) * Format(digits = 2) * (Percent("row") + 1), data = ss.df)

  WriteTableToLatex(sstable, "status_predict.tex")
}

GenerateTreeImg <- function(dtree, filename)
{
  pdf(sprintf('Gen/Img/%s.pdf', filename),width=9,height=7,paper='special')
  prp(dtree, type=2, extra=104,nn=T, fallen.leaves = F, branch.col = "gray40", branch.lty = 5,box.col = c("gray80",'gray40'))
  dev.off()
}

# Generates output directories if they are not created
GenerateDirectories()

#conn <- odbcConnectExcel2007("dados.xlsx")
#calvo <- sqlFetch(conn, "CALVOshrt")
#odbcClose(conn)
calvo <- ReadDataFrameFromFilepath("Calvo.csv")

# Initial analysis plots
GenerateStatusPlot(calvo)
GenerateNaturezaStatusPlot(calvo)
GenerateRendaPlot(calvo)
# Tables
CreateStatusTable(calvo)
CreateStatusNaturezaTable(calvo)
CreateStatusEstadoCivilTable(calvo)
CreateStatusEscolaridadeTable(calvo)
CreateStatusUfTable(calvo, "status_estado.tex")
# Correlation plots
calvo <- NormalizeUfInDataFrame(calvo)
CreateStatusUfTable(calvo, "status_estado_normalized.tex")

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
ac1 <- rpart(data = calvo.lrn, STATUS~UF+ESCOLARIDADE+ESTCIV+FAIXARENDA+NATUREZA)
GenerateTreeImg(ac1, "training_tree")
prp(ac1, type=1, extra=104, fallen.leaves = FALSE, branch.type = 1, faclen = 30)
ac1
print(ac1, digits = 2)
printcp(ac1)

#Teste
ac2 <- rpart(data = calvo.tst, STATUS~UF+ESCOLARIDADE+ESTCIV+FAIXARENDA+NATUREZA)
GenerateTreeImg(ac2, "test_tree")
prob = predict(ac2, newdata = calvo.tst, type = "prob")
head(prob)

#Probabilidade
phat_tst = predict(ac1, newdata = calvo.tst, type = "prob")
phat_tst
yhat_tst = predict(ac1, newdata = calvo.tst, type = "class")

CrossTable(calvo.tst$STATUS, yhat_tst, prop.chisq = F, prop.t = F, digits = 2)
CreateTreeTestTable(calvo.tst, yhat_tst)
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

