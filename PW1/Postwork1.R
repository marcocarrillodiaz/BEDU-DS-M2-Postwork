setwd("/cloud/project/PW1")

# Definimos la url de descarga de archivos
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv";

# Descargamos los archivos
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb");

#Carga de datos
sp1_19_20 <- read.csv('SP1-1920.csv')

#Goles anotados por el equipo de casa
fthg<-sp1_19_20$FTHG

# Goles anotados por el equipo visitante
ftag<-sp1_19_20$FTAG

# Creamos la tala de frecuencias tabla_FTHG
tabla_FTHG<-as.data.frame(table(sp1_19_20$FTHG))
#Calculamos la Probabilidad Marginal
tabla_FTHG$PM<-prop.table(tabla_FTHG$Freq)

# Creamos la tala de frecuencias tabla_FTAG
tabla_FTAG<-as.data.frame(table(sp1_19_20$FTAG))
#Calculamos la Probabilidad Marginal
tabla_FTAG$PM<-prop.table(tabla_FTAG$Freq)

#Creamos la tabla de Frecuencias de los resultados:
#sp1_19_20$Result<-paste(as.character(sp1_19_20$FTHG), '-', as.character(sp1_19_20$FTAG))
tabla_Resultados<-as.data.frame(table(sp1_19_20$FTHG, sp1_19_20$FTAG))
#Calculamos la Probabilidad Conjunta
tabla_Resultados$PConjunta <- prop.table(tabla_Resultados$Freq)
