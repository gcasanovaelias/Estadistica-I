# Pregunta 18 ----
# En un predio se determinó el porcentaje de animales enfermos y el número de cabezas por
# raza, los que se resumen en la tabla:

raza <- tibble(Raza = c("Hereford", "Angus", "Charoláis"),
               h.enfermos = c(2.5, 3.4, 5),
               f.total = c(1200, 800, 2400))

# a) Calcule el número de animales enfermos por raza

raza <- raza %>% 
  group_by(Raza) %>% 
  mutate(f.enfermos = f.total*h.enfermos/100)

# b) Calcule el porcentaje promedio simple de animales enfermos en el predio.

weighted.mean(x = raza$h.enfermos,
              w = raza$f.total)

# c) Calcule el porcentaje de animales enfermos en el predio, sin importar raza.

raza %>% 
  pull(h.enfermos) %>% 
  mean()

# Pregunta 19 ----
# Durante un mes los siguientes ingredientes de una ración tuvieron la variación de precios
# que se indican:

ingredientes <- tibble(Ingrediente = c("Maíz", "Cebada", "Heno", "Afrechillo", "Harina de pescado", "Otros"),
                       Var.percen = c(10, -6, -8, 5, 7, 12),
                       Costo = c(15, 5, 4, 6, 9, 3))

# a) calcule la variación promedio en el mes, sin considerar el costo de los ingredientes

ingredientes %>% 
  pull(Var.percen) %>% 
  mean()

# b) calcule la variación promedio en el mes, considerando el costo de los ingredientes

weighted.mean(x = ingredientes$Var.percen,
              w = ingredientes$Costo)

# Pregunta 20 ----
# Un enfermo obtuvo los siguientes resultados en 3 exámenes: A= 50,35; B= 5,48; C= 0,03 Se sabe
# que estas pruebas en individuos sanos se caracteriza por los siguientes valores

examen <- tibble(Examen = LETTERS[1:3],
                 Results = c(50.35, 5.48, 0.03),
                 Mean = c(45.2, 5.31, 0.02),
                 SD = c(3.432, 0.574, 0.003))

s <- ggplot(data = examen, aes(x = "", y = Mean, color = Examen)) +
  geom_point() +
  geom_errorbar(aes(ymin = Mean - SD, ymax = Mean + SD),
                width = .2,
                position = position_dodge(0.05),
                show.legend = F) +
  geom_point(data = examen, aes(y = Results), shape = "circle open") +
  labs(title = "Comparación exámenes",
       subtitle = "Resultados A, B y C",
       x = "",
       y = "Valores promedio")

s + facet_wrap(~ Examen, 
               dir = "v",
               scales = "free",
               strip.position = "top")

s + facet_grid(Examen ~ .,
               scales = "free")








