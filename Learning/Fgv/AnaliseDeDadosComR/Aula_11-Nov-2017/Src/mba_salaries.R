library('tidyverse')
library('dplyr')
library('corrplot')
library('GGally')

# Constants
mba.salary.sexlabels <- c("Masc", "Fem")
mba.salary.selectedcolumns <- c("salary", "age", "sex", "quarter", "sexlabel")

mba.salary.histogram  <- function(mba.df, name)
{
  # Plots histogram
  ggplot(data = mba.df, aes(x = salary)) +
    geom_histogram() +
    scale_x_continuous(name = "Salário anual ($)") +
    scale_y_continuous(name = "Frequência (%)")
  ggsave(sprintf("Img/histogram_%s.pdf", name))

  # Plots boxplot 
  ggplot(data = mba.df, aes(x = sexlabel, y = salary)) +
    geom_boxplot() +
    scale_x_discrete(name = "Gênero", labels = mba.salary.sexlabels) +
    scale_y_continuous(name = "Salário anual ($)")
  ggsave(sprintf("Img/boxplot_%s.pdf", name))
}

mba.salary.valids <- function(mba.df)
{
  salary.constants.unemployed <- 0
  salary.constants.didntanswer <- 998
  salary.constants.didntdisclose <- 999

  salary.mask.unemployed <- mba.df$salary == salary.constants.unemployed
  salary.mask.didntanswer <- mba.df$salary == salary.constants.didntanswer
  salary.mask.didntdisclose <- mba.df$salary == salary.constants.didntdisclose

  mba.df.valids <- (filter(mba.df, mba.df$salary != salary.constants.unemployed & mba.df$salary != salary.constants.didntanswer & mba.df$salary != salary.constants.didntdisclose))

  return (mba.df.valids)
}

mba.salary.removeoutliers <- function(mba.df)
{
  salary <- mba.df$salary
  salary.mask <- abs(salary - mean(salary)) < 2 * sd(salary)

  return (filter(mba.df, salary.mask))
}

dir.create.imgdir <- function()
{
  dir.create(file.path(".", "Img"), showWarnings = FALSE)
}

mba.salary.readorig <- function()
{
  mba.df <- read.csv("mba_salaries.csv")
  # Adds sex label factor to dataframe
  mba.df$sexlabel <- factor(mba.df$sex, labels = mba.salary.sexlabels)

  return (mba.df)
}

mba.salary.lm.full <- function(mba.df)
{
  x <- mba.df
  return (lm(formula = x$salary ~ x$age + x$sex + x$gmat_tot + x$gmat_qpc + x$gmat_vpc + x$gmat_tpc + x$s_avg + x$f_avg + x$quarter + x$work_yrs + x$frstlang + x$satis))
}

mba.salary.onlynumeric <- function(mba.df)
{
  # Removes non-numeric columns for plot
  mba.df.numeric <- mba.df[ ,-which(names(mba.df) %in% c("sexlabel", "agelabel"))]

  return (mba.df.numeric)
}

mba.salary.corrplot <- function(mba.df, plot.name)
{
  mba.df.numeric <- mba.salary.onlynumeric(mba.df)

  #Plot to file
  pdf(sprintf('Img/corrplot_%s.pdf', plot.name),width=7,height=7,paper='special')
  corrplot(cor(mba.df.numeric), method = "circle")
  dev.off()
}

mba.salary.finaldf <- function(mba.df)
{
  mba.df.final <- mba.df.nooutliers[mba.salary.selectedcolumns]
  # Jovem (J), Jovem Adulto (JA), Adulto (A)
  mba.df.final$agelabel <- cut(mba.df.nooutliers$age, breaks = c(20, 25, 30, 40), labels = c("J", "JA", "A"))

  pdf(sprintf('Img/%s.pdf', 'final_agelabel'),width=10,height=7,paper='special')
  print(ggpairs(mba.df.final, aes(color = agelabel)))
  dev.off()

  pdf(sprintf('Img/%s.pdf', 'final_sexlabel'),width=10,height=7,paper='special')
  print(ggpairs(mba.df.final, aes(color = sexlabel)))
  dev.off()
}

#Ensures that the Img dir is created
dir.create.imgdir()

#Generates histograms
mba.df <- mba.salary.readorig()
mba.salary.histogram(mba.df, "orig")
mba.df.valids <- mba.salary.valids(mba.df)
mba.salary.histogram(mba.df.valids, "mod")
mba.df.nooutliers  <- mba.salary.removeoutliers(mba.df.valids)
mba.salary.histogram(mba.df.nooutliers, "nooutliers")

#Correlation plots
mba.salary.corrplot(mba.df.nooutliers, "nooutliers")
summary(mba.salary.lm.full(mba.df.nooutliers))
mba.salary.finaldf(mba.df.nooutliers)
