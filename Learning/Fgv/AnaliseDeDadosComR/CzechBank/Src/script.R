source.directory <- "Src"
data.directory <- "Data"

GetDataFilepath <- function(filename)
{
  return (sprintf("%s/%s", data.directory, filename))
}

GetSrcFilepath <- function(filename)
{
  return (sprintf("%s/%s", source.directory, filename))
}

RunSrcFromPath <- function(filename)
{
  source(GetSrcFilepath(filename))
}

# Sets working directory to this dir
#setwd.scriptdir <- function()
#{
  #this.dir <- dirname(parent.frame(2)$ofile)
  #setwd(sprintf("%s/..", this.dir))
#}

#setwd.scriptdir()

RunSrcFromPath("clients.R")
