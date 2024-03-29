library(tidyverse)
library(readxl)

#########################################
##########1.LECTURA####################
#########################################
setwd("D:/Cursos/Limpieza de Base de dtos con R")
precios19 <- read_xlsx("Data/precios2019.xlsx")
precios20<- read_xlsx("Data/precios2020.xlsx")

#################################################
##############2.EXPLORACI�N Y MERGE#################
###############################################
dim(precios19)
dim(precios20)
summary(precios20)
head(precios20, 3)
tail(precios20, 3)
glimpse(precios20)

precios<-merge(precios19,precios20, by='Empresas')
precios<-merge(precios19,precios20, by='Empresas', all.x = TRUE) 
precios<-merge(precios19,precios20, by='Empresas', all.x = TRUE, suffixes = c(".2019",".2020"))
######################################################
#############2. Dplyr: select() filter() arrange()``mutate() summarize()###########
#######################################################
#1. Select
select(precios, Aceite.2019)
select(precios, Aceite.2019, Aceite.2020)
select(precios19, -Aceite)

#2. Filter
summary(precios20)
precios.miel<-filter(precios20,`Miel (envasado)` >18.14)
empresa1.2020<-filter(precios20, Empresas=="Empresa 1")


#3. Mutate
precios<- mutate(precios, Aceite.promedio=((Aceite.2019+Aceite.2020)/2))
precios<- mutate(precios, variaci�n=Aceite.2020-Aceite.2019,
                 variaci�n=ifelse(variaci�n>0,"Subi� el aceite", "Baj� el aceite"))

#4. Arrange

precios.arrange <- arrange(precios, Aceite.promedio)
precios.arrange <- arrange(precios, desc(Aceite.promedio))

precios.arrange2 <- precios %>%
  mutate(Aceite.promedio=((Aceite.2019+Aceite.2020)/2))%>%
  mutate(precios, variaci�n=Aceite.2020-Aceite.2019,
         variaci�n=ifelse(variaci�n>0,"Subi� el aceite", "Baj� el aceite")) %>%
  arrange(desc(Aceite.promedio))


####################################################
###################3.Tidyr######################
#################################################


####################################################
###################4.Tratamiento de NANs######################
#################################################

###################################################
###############5.Variables cualitativas########
###############################################
