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


