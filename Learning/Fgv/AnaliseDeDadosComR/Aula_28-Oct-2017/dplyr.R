library(dplyr)

#Generates data.frame "cor"
generate.colors <- function()
{
  colors <- data.frame(cor = c("azul", "preto", "azul", "azul", "preto"), valor=1:5)

  return (colors)
}

#dplyr Filter examples - select rows
print(generate.colors())
cores <- generate.colors()

filter(cores, cor == "azul")
filter(cores, valor %in% c(1,4))

#dplyr Select examples - columns
select(cores, cor) #only color
select(cores, -cor) #all except color

arrange(cores, cor)
arrange(cores, desc(cor))

mutate(cores, dobro = valor * 2) #applies transform to column

# Reduces dataset
summarize(cores, total = sum(valor))

# Groups by color and sums
cores.grupos <- group_by(cores, cor)
# Displays total sum per color groups
summarize(cores.grupos, total = sum(valor))

generate.beatles.names <- function()
{
  return (c("John", "Paul", "George", "Ringo", "Stuart", "Pete"))
}

generate.beatles.frame <- function()
{
  names <- generate.beatles.names()
  instruments <- c("guitar", "bass", "guitar", "drums", "bass", "drums")

  return (data.frame(names, instruments))
}

generate.bands.frame <- function()
{
  names <- c(generate.beatles.names()[1:4], "Brian")
  band <- c(TRUE, TRUE, TRUE, TRUE, FALSE)

  return (data.frame(names, band))
}

beatles.band <- generate.beatles.frame()
band.names <-generate.bands.frame()

inner_join(beatles.band, band.names, by = ("names" = "names"))
left_join(beatles.band, band.names)
right_join(beatles.band, band.names)
semi_join(beatles.band, band.names)
anti_join(beatles.band, band.names, by = c("names" = "names"))
