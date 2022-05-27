# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R

# Fijamos nuestro directorio de trabajo
setwd("/cloud/project/PW2")
# Definimos la url de descarga de archivos
u1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv";
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv";
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv";
u2021 <- "https://www.football-data.co.uk/mmz4281/2021/SP1.csv";

# Descargamos los archivos
download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb");
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb");
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb");
download.file(url = u2021, destfile = "SP1-2021.csv", mode = "wb");

# 2. Obtén una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary
# Leemos los archivos descargados y los asignamos a variables
f1718 <- read.csv('SP1-1718.csv');
f1819 <- read.csv('SP1-1819.csv');
f1920 <- read.csv('SP1-1920.csv');
f2021 <- read.csv('SP1-2021.csv');

str(f1718);
head(f1718);
View(f1718);
summary(f1718);

str(f1819);
head(f1819);
View(f1819);
summary(f1819);

str(f1920);
head(f1920);
View(f1920);
summary(f1920);

# 3. Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: también puedes usar lapply).
# Cargamos dplyr
#install.packages('dplyr')
suppressMessages(suppressWarnings(library(dplyr)));

# Usando select
s1718 <- select(f1718, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR);
s1819 <- select(f1819, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR);
s1920 <- select(f1920, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR);
s2021 <- select(f2021, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR);

# Usando lapply
# dir();
# Guardamos los archivos en una lista
lista <- lapply(dir(), read.csv);
lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR);

# 4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: use as.Date y mutate para arreglar las fechas). Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).
s1718 <- rename(s1718, Fecha=Date); 
s1819 <- rename(s1819, Fecha=Date);
s1920 <- rename(s1920, Fecha=Date);
s2021 <- rename(s2021, Fecha=Date);

#vs_1718$Date =as.Date(vs_1718$Date ,format="%d/%m/%y")
# El df s1718 no tiene el año completo, por lo que le damos formato a este vector
# Le damos formato al año de fecha, integrandole el prefijo 20 al año
s1718$Fecha <- paste(substr(s1718$Fecha, 1, 6),'20',substr(s1718$Fecha,7,8), sep='');
#s1819$Fecha <- paste(substr(s1819$Fecha, 1, 6),'20',substr(s1819$Fecha,7,8), sep='');
#s1920$Fecha <- paste(substr(s1920$Fecha, 1, 6),'20',substr(s1920$Fecha,7,8), sep='');

# Transformamos el tipo de dato de fecha de char a date
s1718 <- mutate(s1718, Fecha=as.Date(Fecha, '%d/%m/%Y'));
s1819 <- mutate(s1819, Fecha=as.Date(Fecha, '%d/%m/%Y'));
s1920 <- mutate(s1920, Fecha=as.Date(Fecha, '%d/%m/%Y'));
s2021 <- mutate(s2021, Fecha=as.Date(Fecha, '%d/%m/%Y'));

#unimos los tres objetos por filas
resultado <- rbind(s1718, s1819, s1920);
View(resultado);


# Usando lapply, renombramos Date a Fecha
lista <- lapply(lista, rename, Fecha=Date);

# Replicamos el mismo trato elaborado para s1718 sobre el campo fecha, dandole formato al año
lista[[1]]$Fecha <- paste(substr(lista[[1]]$Fecha, 1, 6),'20',substr(lista[[1]]$Fecha,7,8), sep='');

# Usando lapply transformamos el tipo de dato de fecha de char a date
lista <- lapply(lista, mutate, Fecha=as.Date(Fecha, '%d/%m/%Y'));

# Por último unimos en un único data frame los tres df de lista usando do.call
datos <- do.call(rbind, lista);
str(datos)
