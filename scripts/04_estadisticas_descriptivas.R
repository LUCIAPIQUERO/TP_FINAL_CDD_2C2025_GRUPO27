# =============================================================================
# SCRIPT 04: ESTADÍSTICAS DESCRIPTIVAS
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero
# OUTPUTS: tablas y gráficos descriptivos en output/
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Traer configuración global, funciones y librerías
source("scripts/00_organizacion_proyecto.R")
source("functions/00_funciones_carga.R")
source("functions/01_funciones_limpieza.R")
source("functions/02_funciones_visualizacion.R")   
source("functions/03_funciones_tablas.R")          
library(ggplot2)
library(patchwork)

# 3. Cargar dataset reducido desde processed
# Nota metodológica:
# Se utiliza el dataset reducido generado en el Script 03, que incluye Profit, Discount,
# variables contextuales y Order_ID para trazabilidad.
datos_reducidos <- readRDS(file.path("data/processed", "datos_reducidos.rds"))

# Cargar dataset sin outliers (generado en Script 03)
datos_no_outliers <- readRDS(file.path("data/processed", "datos_no_outliers.rds"))

# -----------------------------------------------------------------------------
# MEDIDAS DE TENDENCIA CENTRAL Y DISPERSIÓN
# -----------------------------------------------------------------------------

# Función para calcular la moda
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Data frame con estadísticas descriptivas (con outliers)
estadisticas_descriptivas_outliers <- data.frame(
  Variable = c("Discount", "Profit"),
  Media = c(mean(datos_reducidos$discount, na.rm = TRUE),
            mean(datos_reducidos$profit, na.rm = TRUE)),
  Mediana = c(median(datos_reducidos$discount, na.rm = TRUE),
              median(datos_reducidos$profit, na.rm = TRUE)),
  Moda = c(get_mode(datos_reducidos$discount),
           get_mode(datos_reducidos$profit)),
  Desvio = c(sd(datos_reducidos$discount, na.rm = TRUE),
             sd(datos_reducidos$profit, na.rm = TRUE)),
  IQR = c(IQR(datos_reducidos$discount, na.rm = TRUE),
          IQR(datos_reducidos$profit, na.rm = TRUE))
)

# Guardar tabla resumen
guardar_tabla(estadisticas_descriptivas_outliers, "estadisticas_descriptivas_outliers")
print(estadisticas_descriptivas_outliers)

# Data frame con estadísticas descriptivas (sin outliers)
estadisticas_descriptivas_sin_outliers <- data.frame(
  Variable = c("Discount", "Profit"),
  Media = c(mean(datos_no_outliers$discount, na.rm = TRUE),
            mean(datos_no_outliers$profit, na.rm = TRUE)),
  Mediana = c(median(datos_no_outliers$discount, na.rm = TRUE),
              median(datos_no_outliers$profit, na.rm = TRUE)),
  Moda = c(get_mode(datos_no_outliers$discount),
           get_mode(datos_no_outliers$profit)),
  Desvio = c(sd(datos_no_outliers$discount, na.rm = TRUE),
             sd(datos_no_outliers$profit, na.rm = TRUE)),
  IQR = c(IQR(datos_no_outliers$discount, na.rm = TRUE),
          IQR(datos_no_outliers$profit, na.rm = TRUE))
)

# Guardar tabla resumen sin outliers
guardar_tabla(estadisticas_descriptivas_sin_outliers, "estadisticas_descriptivas_sin_outliers")
print(estadisticas_descriptivas_sin_outliers)

# -----------------------------------------------------------------------------------------------------
# HISTOGRAMAS DE VARIABLE PROFIT
# -----------------------------------------------------------------------------------------------------
# Calcular valores
media_con_outliers <- mean(datos_reducidos$profit, na.rm = TRUE)
mediana_con_outliers<- median(datos_reducidos$profit, na.rm = TRUE)

media_sin_outliers <- mean(datos_no_outliers$profit, na.rm = TRUE)
mediana_sin_outliers <- median(datos_no_outliers$profit, na.rm = TRUE)

# Histograma con outliers
p_profit_con <- ggplot(datos_reducidos, aes(x = profit)) +
  geom_histogram(binwidth = 50, fill = "firebrick", color = "black", alpha = 0.7) +
  geom_vline(xintercept = media_con_outliers, linetype = "dashed", color = "darkgreen", size = 1) +   # Media en verde
  geom_vline(xintercept = mediana_con_outliers, linetype = "dotted", color = "purple", size = 1) +   # Mediana en violeta
  labs(title = "Con Outliers", x = "Profit (USD)", y = "Nro. de Observaciones") +
  tema_proyecto() +
  scale_y_continuous(limits = c(0, 3000)) +
  theme(axis.title.y = element_text(margin = margin(r = 15)))

# Histograma sin outliers
p_profit_sin <- ggplot(datos_no_outliers, aes(x = profit)) +
  geom_histogram(binwidth = 10, fill = "steelblue", color = "black", alpha = 0.7) +
  geom_vline(xintercept = media_sin_outliers, linetype = "dashed", color = "darkgreen", size = 1) +   # Media en verde
  geom_vline(xintercept = mediana_sin_outliers, linetype = "dotted", color = "purple", size = 1) +   # Mediana en violeta
  labs(title = "Sin Outliers", x = "Profit (USD)", y = " ") +
  tema_proyecto() +
  scale_y_continuous(limits = c(0, 3000))

# Comparación con patchwork
grafico_profit <- (p_profit_con | p_profit_sin) +
  plot_annotation(
    title = "¿Cómo afecta la exclusión de Outliers a la distribución de la Ganancia?",
    subtitle = "Comparación de la distribución de frecuencia de la variable Profit con y sin outliers",
    caption = "Fuente: Sample - Superstore"
  )

# Guardar y mostrar
guardar_grafico(grafico_profit, "histograma_profit_comparacion")
print(grafico_profit)

# -----------------------------------------------------------------------------
# DISTRIBUCIÓN DE FRECUENCIAS PARA VARIABLES CATEGÓRICAS
# -----------------------------------------------------------------------------

tabla_cat <- table(datos_reducidos$category)
guardar_tabla(tabla_cat, "frecuencia_category")

tabla_reg <- table(datos_reducidos$region)
guardar_tabla(tabla_reg, "frecuencia_region")

tabla_seg <- table(datos_reducidos$segment)
guardar_tabla(tabla_seg, "frecuencia_segment")

# -----------------------------------------------------------------------------
# GRÁFICOS DE FRECUENCIAS PARA VARIABLES CATEGÓRICAS
# -----------------------------------------------------------------------------
# Calcular máximo común de observaciones
max_val <- max(
  table(datos_reducidos$category),
  table(datos_reducidos$region),
  table(datos_reducidos$segment)
)

# Frecuencia por categoría (con etiqueta en eje Y y margen extra)
p_cat <- ggplot(datos_reducidos, aes(x = category, fill = category)) +
  geom_bar(color = "black") +
  labs(title = "Categoría", x = NULL, y = "Nro. de Observaciones") +
  tema_proyecto() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.y = element_text(margin = margin(r = 10))   # separa el título del eje
  ) +
  scale_y_continuous(limits = c(0, max_val))

# Frecuencia por región (sin etiqueta en eje Y)
p_reg <- ggplot(datos_reducidos, aes(x = region, fill = region)) +
  geom_bar(color = "black") +
  labs(title = "Región", x = NULL, y = NULL) +
  tema_proyecto() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  scale_y_continuous(limits = c(0, max_val))

# Frecuencia por segmento (sin etiqueta en eje Y)
p_seg <- ggplot(datos_reducidos, aes(x = segment, fill = segment)) +
  geom_bar(color = "black") +
  labs(title = "Segmento", x = NULL, y = NULL) +
  tema_proyecto() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  scale_y_continuous(limits = c(0, max_val))

grafico_frecuencias <- (p_cat | p_reg | p_seg) +
  plot_annotation(
    title = "¿Las variables complementarias cuentan con distribuciones uniformes?",
    subtitle = "Comparación entre categorías, regiones y segmentos",
    caption = "Fuente: Sample - Superstore",
    theme = theme(
      plot.title = element_text(face = "bold", size = 18, family = "serif"),
      plot.subtitle = element_text(size = 12, family = "serif"),
      plot.caption = element_text(size = 9, face = "italic", family = "serif")
    )
  )

print(grafico_frecuencias)
guardar_grafico(grafico_frecuencias, "frecuencias_variables_complementarias")

# Guardar y mostrar
print(grafico_frecuencias)
guardar_grafico(grafico_frecuencias, "frecuencias_variables_complementarias")
