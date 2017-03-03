########################################################################################
##
## ENV400 example script
## 2016 Mar
##
########################################################################################

## ------------------------------------------------------------------------
library(dplyr)
library(reshape2)
library(chron)
library(ggplot2)

## ------------------------------------------------------------------------
source("GRB001.R")

## ------------------------------------------------------------------------
Sys.setlocale("LC_TIME","C")
options(stringsAsFactors=FALSE)
options(chron.year.abb=FALSE)
theme_set(theme_bw()) # just my preference for plots

## ------------------------------------------------------------------------
BERN <- "data/BER_BOLL_16-17.csv"
file.exists(BERN)

SION <- "data/SIO_AERO_16-17.csv"
file.exists(SION)

## ------------------------------------------------------------------------
data <- read.table(BERN,sep=";",skip=7,
  col.names=c("datetime","O3","NO2","CO","PM10","CPC","NOX","TEMP","PREC","RAD"))

data <- read.table(SION,sep=";",
  col.names=c("datetime","O3","NO2","PM10","NOX","TEMP","PREC","RAD"))

print("here", quote = TRUE)
## CONTROL------------------------------------------------------------------------
head(data)
tail(data)
str(data)
ColClasses(data) ## results='asis'

## ------------------------------------------------------------------------
data[,"datetime"] <- as.chron(data[,"datetime"], "%d.%m.%Y %H:%M")
data[,"month"] <- months(data[,"datetime"])
data[,"date"] <- dates(data[,"datetime"])

## CONTROL POST datetime TRANSFORMATION------------------------------------------------------------------------
head(data)
str(data)
ColClasses(data)

## ---- fig.width=8, fig.height=5------------------------------------------
ggp <- ggplot(data)+
  geom_line(aes(datetime, O3))+
    scale_x_chron()
print(ggp)

dir.create("outputs")

pdf("outputs/fig1.pdf")
print(ggp)
dev.off()


print("finish him", quote = TRUE)

