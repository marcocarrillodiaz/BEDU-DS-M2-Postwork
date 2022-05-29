#install.packages('ggplot2')
library(ggplot2) # Cargamos la libreria ggplot2

df.HG <- as.data.frame(table(datos$FTHG))
df.HG <- rename(df.HG, HG=Var1)
df.HG <- transform(df.HG,
                   FreqAcm=cumsum(df.HG$Freq),
                   FreqRel=prop.table(df.HG$Freq),
                   FreqRelAcm=cumsum(prop.table(df.HG$Freq)))
#   b. La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
df.AG <- as.data.frame(table(datos$FTAG))
df.AG <- rename(df.AG, AG=Var1)
df.AG <- transform(df.AG,
                   FreqAcm=cumsum(df.AG$Freq),
                   FreqRel=prop.table(df.AG$Freq),
                   FreqRelAcm=cumsum(prop.table(df.AG$Freq)))
#   c. La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
df.HGvsAG <- as.data.frame(table(datos$FTHG, datos$FTAG))
head(df.HGvsAG)
df.HGvsAG <- rename(df.HGvsAG, HG=Var1, AG=Var2)
df.HGvsAG <- transform(df.HGvsAG,
                       FreqAcm=cumsum(df.HGvsAG$Freq),
                       FreqRel=prop.table(df.HGvsAG$Freq),
                       FreqRelAcm=cumsum(prop.table(df.HGvsAG$Freq)))

# a. Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
df.HG %>% 
  ggplot() +
  aes(x = HG, y = FreqRel) +
  #geom_histogram(binwidth = 10, col="black", fill = "blue") +
  geom_bar(stat = 'identity', col="black", fill = "blue") +
  ggtitle("Histograma de Goles Equipo de Casa") +
  ylab('Probabilidad Marginal') +
  xlab('Cantidad Goles Casa') +
  theme_light()
#   b. Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
df.AG %>% 
  ggplot() +
  aes(x = AG, y = FreqRel) +
  #geom_histogram(binwidth = 10, col="black", fill = "gray") +
  geom_bar(stat = 'identity', col="black", fill = "gray") +
  ggtitle("Histograma de Goles Equipo Visitante") +
  ylab('Probabilidad Marginal') +
  xlab('Cantidad Goles Visitante') +
  theme_light()
#   c. Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
# install.packages('pheatmap')
library(pheatmap)
(table(datos$FTHG, datos$FTAG)/1520) %>% 
  pheatmap(display_numbers = TRUE)
