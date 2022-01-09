# Packages ----
library(tidyverse)
library(agricolae)

# Pregunta 1 ----
#* Represente gráficamente de dos maneras diferentes la información del número de cajas
#* exportadas de las siguientes especies:

datos_frutas <- tibble(Especie = c("Uva blanca", "Uva negra y rosada", "Pómaceas", "Carozos"),
                       N.cajas = c(185, 157, 215, 139))

# Barplot
ggplot(data = datos_frutas, aes(x = Especie, y = N.cajas, fill = Especie)) + 
  geom_bar(stat = "identity") +
  labs(title = "N° cajas por especie de fruta",
       subtitle = "Datos",
       y = "N° cajas (miles)",
       x = "Especie") +
  theme(legend.position = "bottom")

# Gráfico de tortas
ggplot(data = datos_frutas, aes(x = "", y = N.cajas, fill = Especie)) +
  geom_bar(stat = "identity") + 
  coord_polar("y", start = 0) +
  labs(title = "N° cajas por especie de fruta",
       subtitle = "Datos") +
  theme_void() +
  theme(legend.position = "bottom")

# Pregunta 2 ----
#* Las causas más frecuentes de atención en caninos en una clínica veterinaria de la comuna de
#* Santiago en dos épocas del año se presenta a continuación:
datos_canino <- tibble(Causa = c("Neumonía", "Gastritis", "Enteritis", "Parasitismo", "Distemper", "Dermatitis", "Traumatismos"),
                       N.atenciones.verano = c(15, 55, 50, 60, 24, 8, 20),
                       N.atenciones.invierno = c(48, 58, 41, 52, 56, 4, 20))

# a) Construya un gráfico de sectores circulares por cada época de atención
# Verano
ggplot(data = datos_canino, aes(x = "", y = N.atenciones.verano, fill = Causa)) +
  geom_bar(stat = "identity") + 
  coord_polar("y", start = 0) +
  labs(title = "N° atenciones en verano",
       subtitle = "Datos clínica veterinaria") +
  theme_void() +
  theme(legend.position = "bottom")

# Invierno
ggplot(data = datos_canino, aes(x = "", y = N.atenciones.invierno, fill = Causa)) +
  geom_bar(stat = "identity") + 
  coord_polar("y", start = 0) +
  labs(title = "N° atenciones en invierno",
       subtitle = "Datos clínica veterinaria") +
  theme_void() +
  theme(legend.position = "bottom")

# b) Construya un gráfico para comparar las causas de atención, sin considerar la época. ¿Cuál(es) s(son) las causas de mayor consulta?
datos_canino %>% 
  mutate(N.atenciones = N.atenciones.verano + N.atenciones.invierno) %>% 
  ggplot(aes(x = Causa, y = N.atenciones, fill = Causa)) + 
    geom_bar(stat = "identity") +
    labs(title = "N° atenciones",
         subtitle = "Datos clinica veterinaria",
         y = "N° atenciones",
         x = " ") + 
    theme(legend.position = "bottom")

# c) Construya un gráfico en que se puedan comparar las causas por época ¿Cuál(es) causas son
# más importantes en verano? ¿Cuál(es) causas son más importantes en invierno?

datos_canino_longer <- datos_canino %>% 
  pivot_longer(cols = starts_with("N.atenciones"),
               names_prefix = "N.atenciones.",
               names_to = "Temporada",
               values_to = "N.atenciones")

ggplot(data = datos_canino_longer, aes(x = Causa, y = N.atenciones, fill = Temporada)) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "N° atenciones",
       subtitle = "Datos clinica veterinaria",
       y = "N° atenciones",
       x = " ") +
  theme(legend.position = "bottom")

# d) Construya otro gráfico en que se puedan comparar las épocas por causa ¿En cuál época es
# más crítica el distemper? ¿En cuál época es más crítica la gastritis?

ggplot(data = datos_canino_longer, aes(x = Temporada, y = N.atenciones, fill = Causa)) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "N° atenciones",
       subtitle = "Datos clinica veterinaria",
       y = "N° atenciones",
       x = " ") +
  theme(legend.position = "bottom")

# Pregunta 3 ----
# En una encuesta sobre hábito de consumo de ciertas frutas de las familias en las comunas de
# Ñuñoa y San Miguel, se obtuvo la siguiente información

data_comunas <- tibble(Fruta = c("Uva de mesa", "Duraznos", "Manzanas", "Peras", "Naranjas", "Kiwis", "Guindas"),
                       Ñuñoa = c(15, 19, 17, 8, 10, 27, 12),
                       San.Miguel = c(14, 10, 20, 12, 18, 12, 6))

data_comunas_longer <- data_comunas %>% 
  pivot_longer(cols = -Fruta,
               names_to = "Comuna",
               values_to = "N.familia")

# b) Represente en un gráfico adecuado estos datos mostrando las preferencias por cada
# comuna.

ggplot(data = data_comunas_longer, aes(x = Fruta, y = N.familia, fill = Comuna)) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Consumo de frutas en familias por comunas",
       subtitle = "Comunas de Ñuñoa y San Miguel",
       y = "N° Familia",
       x = "Frutas") + 
  theme(legend.position = "bottom")

# c) Construya otro gráfico que permita la comparación adecuada entre las comunas.

ggplot(data = data_comunas_longer, aes(x = Comuna, y = N.familia, fill = Fruta)) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Consumo de frutas en familias por comunas",
       subtitle = "Comunas de Ñuñoa y San Miguel",
       y = "N° Familia",
       x = "Comunas") + 
  theme(legend.position = "bottom")

# Pregunta 4 ----
# En una encuesta a 600 productores de trigo se les consultó sobre superficie sembrada y la
# tecnología empleada en su predio. Posteriormente fueron clasificados en tres categorías de tamaño
# y tres niveles de tecnología, dando origen a la siguiente información

data_productores <- tibble(Tamaño = c("Pequeño", "Mediano", "Grande"),
                           Bajo = c(182, 68, 20),
                           Mediano = c(85, 60, 41),
                           Alto = c(33, 72, 39))

data_productores_longer <- data_productores %>% 
  pivot_longer(cols = -Tamaño,
               names_to = make.names("Nivel tecnologico"),
               values_to = "f")

# a) Construya un gráfico que permita comparar adecuadamente nivel tecnológico según tamaño
ggplot(data = data_productores_longer, 
       aes(x = Nivel.tecnologico, y = f, fill = Tamaño)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Nivel tecnológico según tamaño de productores de trigo",
       subtitle = "Datos de superficie sembrada y tecnología empleada",
       x = "Nivel tecnológico",
       y = "Frecuencia absoluta (N°)") +
  theme(legend.position = "bottom")

# b) Construya un gráfico adecuado para comparar tamaño según nivel tecnológico 
ggplot(data = data_productores_longer, 
       aes(x = Tamaño, y = f, fill = Nivel.tecnologico)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Tamaño de productores según nivel tecnológico",
       subtitle = "Datos de superficie sembrada y tecnología empleada",
       x = "Tamaño",
       y = "Frecuencia absoluta (N°)") +
  theme(legend.position = "bottom")

# Pregunta 5 ----
# La tabla muestra la distribución de 340 plantas enfermas que fueron sometidas a uno de los cuatro
# tratamientos curativos A, B, C y D, de acuerdo a su condición después de finalizado el tratamiento

datos_plantas <- tibble(Tratamiento = LETTERS[1:4],
                        Mejor = c(13, 34, 22, 35),
                        Igual = c(43, 28, 18, 31),
                        Peor = c(14, 38, 10, 54))

datos_plantas_longer <- datos_plantas %>% 
  pivot_longer(cols = -Tratamiento,
               names_to = "Condicion",
               values_to = "f")

# Construya gráficos en que se puedan comparar los resultados por tratamiento:
s <- ggplot(data = datos_plantas_longer, aes(x = Tratamiento, y = f, fill = Condicion)) +
  labs(title = "Condición de plantas enfermas posterior a tratamientos",
       subtitle = "Distribución de 340 plantas enfermas",
       x = "Tratamiento",
       y = "Frecuencia") +
  theme(legend.position = "bottom")

# a) En valores absolutos
s + geom_bar(stat = "identity", position = "stack")

# b) En valores porcentuales
s + geom_bar(stat = "identity", position = "fill")

# Pregunta 6 ----
#  La información de la tabla corresponde a la producción de carne de ganado bovino (en ton.), por
# categoría, durante 5 años en un matadero de Santiago

dato_carne <- tibble(Año = seq(from = 1997, to = 2001),
                     Novillos = c(89762, 96710, 94104, 114023, 123071),
                     Vacas = c(67270, 74084, 80764, 85450, 90127),
                     Bueyes = c(12941, 14105, 16730, 19836, 21320), 
                     Vaquillas = c(59742, 64200, 70465, 73015, 76842),
                     Terneros = c(12345, 8920, 7450, 6678, 8240))

dato_carne_longer <- dato_carne %>% 
  pivot_longer(cols = -Año,
               names_to = "Categoría",
               values_to = "Producción")

# a) Construya un gráfico lineal que muestre la producción de carne por categoría.
ggplot(data = dato_carne_longer, aes(x = Año, y = Producción, color = Categoría)) +
  geom_line() +
  geom_point() +
  labs(title = "Producción anual de carne bovina por categoría",
       subtitle = "Matadero de Santiago", 
       x = "Años",
       y = "Producción (ton)") +
  theme_minimal() +
  theme(legend.position = "bottom")

# b) Muestre la información anterior mediante un gráfico de barras agrupadas por categoría.
ggplot(data = dato_carne_longer, aes(x = Año, y = Producción, fill = Categoría)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Producción anual de carne bovina por categoría",
       subtitle = "Matadero de Santiago", 
       x = "Años",
       y = "Producción (ton)") +
  theme_minimal() +
  theme(legend.position = "bottom")
