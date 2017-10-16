#!/usr/bin/env Rscript

# Student: Andre Bem
# Class: Analise de Dados com R
# Exercises: R for Data Scientitst (3.5.1)

# Easy requirement for the whole tidyverse package including ggplot2 and others
library('tidyverse')

#This one plots one for each individual value
exercise1 <- function()
{
  ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))  + facet_wrap(~ displ)
  ggsave("Img/exercise1.pdf")
}

exercise2 <- function()
{
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = drv, y = cyl))
  ggsave("Img/exercise2-1.pdf")

  ggplot(data = mpg) +
    geom_point(mapping = aes(x = drv, y = cyl)) +
    facet_grid(drv ~ cyl)
  ggsave("Img/exercise2-2.pdf")
}

exercise3 <- function()
{
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ .)
  ggsave("Img/exercise3-1.pdf")
  
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(. ~ cyl)
  ggsave("Img/exercise3-2.pdf")
}

exercise4 <- function()
{
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
    facet_wrap(~ class, nrow = 2)
  ggsave("Img/exercise4-1.pdf")

  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))
  ggsave("Img/exercise4-2.pdf")
}

exercise5 <- function()
{
  #Exercise is read-manual only has no related code
}

exercise6 <- function()
{
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(fl ~ drv)
  ggsave("Img/exercise6-1.pdf")

  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ fl)
  ggsave("Img/exercise6-2.pdf")

}

dir.create.imgdir <- function()
{
  dir.create(file.path(".", "Img"), showWarnings = FALSE)
}

#Ensures that the Img dir is created
dir.create.imgdir()

exercise1()
exercise2()
exercise3()
exercise4()
exercise6()
