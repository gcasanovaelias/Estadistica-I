# R ----
# R es un lenguaje de programación basado en el objetos. 
#* No sólo se pueden crear objetos si no que estos pueden formar parte de las operaciones (dentro de ellos o entre distintos objetos)

# Clases de objetos ----
#* Existen 5 tipos de objetos que son manejables en R 

chr <- c("Estadistica", "RRNN", "UCHILE") # (1) Caracter

num <- c(1,2,3) # (2) Numérico (continuo)

int <- c(1L,# (3) Entero (numérico discreto) 
         2L,3L) #Se designan con un L (mayúscula). Discretización de un valor, necesario para la construcción de tabla de frecuencias más adelante (si se realiza con continuas sale error)

cplx <- c(8i, # (4) Complejo. i = raiz de -1 (imaginario).
          9 + 9i, # Designación de número complejos tambien involucra número reales (además de imaginarios)
          10)

logi <- c(FALSE, FALSE, TRUE, F, T) # (5) Lógico. Son objetos que en su interior presentan verdaderos (T) o falsos (F). Presentan una gran utilidad a la hora de filtrar.

# ¿Qué tipo de objeto es? ¿Cual es su naturaleza?

str(cplx)

class(cplx)

typeof(cplx)

# Implicit coercion ----
#* R acepta objetos "puros" (de un solo tipo). El tipo de objetos es excluyente. No se puede tener dos naturalezas en el mismo objeto.
#* R toma la decisión de si un objeto es de un tipo u otro

b <- c(1,2,FALSE);b;str(b) #F: se convierte en 0 debido a que el objeto creado es del tipo numérico (coerciona a otros valores a convertirse en num)

# Explicit coercion ----
#* Cambio forzado (por el usuario) del tipo de objeto

# Forzar al objeto b (num) a ser lógico (logi)
as.logical(b) # F: 0, T: todo lo que sea distinto de 0 será T

# No siempre será posible realizar una coersión explícita sobre un objeto
f <- c("hola", "chao");f;str(f)

as.numeric(f) #NA: Not Available

# Estructura de datos ----
#* Existen las matrices, data frames, vectores y listas. 

# A pesar de que los objetos son excluyentes, se pueden combinar objetos de distinta naturaleza manteniendo su independencia (lista)
list(chr, cplx, logi)

# Del mismo modo, en los data frames cada columna puede presentarse una naturaleza distinta
df <- data.frame(Pais = c("Chile", "Perú", "Bolivia", "Uruguay"),
                 Habitantes = c(18, 22, 9, 5),
                 PIB = c(100, 200, 300, 350))

str(df)

df.1 <- data.frame(A = chr, B = cplx)

# Subseteo ----
#* Selección de datos 
df[,1]

# Seleccionar los paises que presenten una cantidad de habitantes mayores de 10

df$Habitantes > 10 # Vector del tipo lógico que permite realizar el filtro

df$Pais[df$Habitantes > 10]

df[df$Habitantes >10 & df$Habitantes < 19,]

# Tidyverse 
df %>% filter(Habitantes < 10, PIB > 300) %>% pull(Pais)

# Modificar df ----
colnames(df) <- c("Paises", "Hab", "PIB");df

df[df$PIB == 200,]

df[2,3] <- 250

rownames(df) <- c("P1", "P2", "P3", "P4")

# Importar un set de datos ----

# Directorio
getwd() # Para saber donde está el directorio

setwd() # Para seleccionar un directorio

# Funciones para importar
#* Tambien se puede emplear el "Import Dataset" en la ventana de Environment (al lado de la escoba) 
data <- read.table(file = "ejemplotext.txt", header = T, sep = " ") # Documento de texto
  #* Tiene que asignarse a un objeto para que funcione

read.csv(file = "ejemplocsv.csv", header = T, sep = ";") # Documento csv

install.packages("readxl")
library(readxl)
readxl::read_xls("ejemploexel.xlls") #tibble es un tipo de data frame

# Tambien se puede poner la ruta completa de un archivo que no se encuentre en el directorio
read.table("~/Casanova/Estudio Personal/ejemplotext.txt")

# Exportar datos ----
# Llevarlo de un objeto R a un archivo excel

install.packages("writexl") # Análogo a readxl
library(writexl)

writexl::write_xlsx(x = df, path = "datox.xlsx")

# Bases de datos ----
data(iris)

# Primera aproximación
str(iris)

head(x = iris, n = 10) # Ver las primeras observaciones de la base de datos

tail(iris) # Ver las últimas observaciones de la base de datos

# ¿Qué especies están presentes?
levels(iris$Species)

unique(iris$Species)

# Filtrado
virginica <- iris[iris$Species == "virginica" & iris$Sepal.Length > 6.5,]

# Tidyverse ----
install.packages("tidyverse") # Colección de 8 librerias
library(tidyverse)

# Pipeline ( %>% ) hace referencia a una secuencia de instrucciones (chaining)

iris %>% 
  # filter(): filtrado
  dplyr::filter(Species == "versicolor", Sepal.Length > 6.5) %>% 
  # arrange(): Ordenar tus datos, desc(): ordenar de manera descendente 
  arrange(desc(Sepal.Width)) %>% 
  # mutate(): Modifica columna/variable o agrega una adicional
  mutate(Ancho = c(1,2,3,4,5,6,7,8), # Agregar una columna nueva (a partir de un nuevo nombre)
         Sepal.Width = Sepal.Width/100) %>% # Modificar una columna ya existente (ocupar el mismo nombre)
  # Exportar con write_xlsx
  writexl::write_xlsx("prueba.xlsx")

iris %>% 
  # group_by(): agrupación de observaciones según una columna o variable. Si no deseo hacer una distinción por especie simplemente se elimina el group_by()
  group_by(Species) %>% 
  # summarise(): resumir descriptivamente una variable
  summarise(media = mean(Sepal.Length),
            desvest = sd(Sepal.Length),
            median = median(Sepal.Length),
            rango = max(Sepal.Length) - min(Sepal.Length),
            CV = sd(Sepal.Length)/mean(Sepal.Length)*100)

iris %>% 
  # select(): seleccionar columnas
  select(-Species) %>% 
  # summarise_all(): calcular estadígrafos para todas las variables
  summarise_all(funs(mean, sd,median))

iris %>% 
  group_by(Species) %>% 
  summarise_all(.funs = list(mean, sd, median))

# Variables cualitativas ----

# Tablas de frecuencia
# table(): calcular la tabla de frecuencia para una variable cualitativa
tabla <- table(iris$Species[iris$Sepal.Length > 5])

str(tabla)
# Es un objeto de tipo tabla, mejor transformarlo a un data frame

tabla <- table(iris$Species[iris$Sepal.Length > 5]) %>% 
  # as.data.frame(): conversión a un data frame
  as.data.frame() %>% 
  rename(Species = Var1, Frequency = Freq) %>% 
  # Calcular la frecuencia relativa
  mutate(Rel.Freq = round(Frequency/sum(Frequency)*100, 2));tabla


# prop.table(): calcular la proporción de una tabla de frecuencia
prop.table(table(iris$Species[iris$Sepal.Length > 5]))

# Gráficos con ggplot2----

# Librería base (graphic)
iris$Species[iris$Sepal.Length > 5] %>% 
  table() %>% 
  barplot()

  # Gráfico de barras
barplot(Frequency ~ Species, 
        data = tabla,
        xlab = "Species",
        ylab = "Frequency",
        main = "Gráfico sencillo",
        col = c("dark blue", "dark red", "dark green"))

  # Gráfico de tortas
iris$Species[iris$Sepal.Length > 5] %>% 
  table() %>% 
  pie()

# ggplot2
#* Permite ir construyendo gráficos por capas
#* www.sthda.com/english/wiki

  # Gráfico de barras
ggplot(data = tabla, aes(x = Species, y = Frequency, fill = Species)) +
  geom_bar(stat = "identity",
           # Cambiar el ancho (0.9 el es valor por defecto)
           width = 0.6) +
  # Cambiar la paleta de colores (requiere que se indique fill en aes())
  scale_fill_brewer(palette = "Reds") +
  theme_minimal()

install.packages("RcolorBrewer")
library(RColorBrewer)
display.brewer.all()


  # Gráfico de tortas
ggplot(data = tabla, aes(x = "", y = Frequency, fill = Species)) +
  geom_bar(stat = "identity") +
  # coord_polar(): transformar a un gráfico de tortas
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "Greens") +
  theme_void()


















