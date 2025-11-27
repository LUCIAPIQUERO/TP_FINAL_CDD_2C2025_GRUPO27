# =============================================================================
# SCRIPT 03: ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero
# OUTPUTS: tablas y gráficos exploratorios en output/
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Traer configuración global, funciones y librerías
source("scripts/00_organizacion_proyecto.R")
source("functions/00_funciones_carga.R")
source("functions/01_funciones_limpieza.R")
source("functions/02_funciones_visualizacion.R")   # tema, colores, guardar_grafico
source("functions/03_funciones_tablas.R")          # guardar_tabla
library(patchwork)
library(dplyr)

# 3. Cargar dataset limpio y reducir variables
# Nota metodológica:
# Se seleccionan solo las variables relevantes para la hipótesis (Profit, Discount)
# y las variables contextuales (Region, Segment, Category).
#Ademas se selecciona la variable Order Id por motivos de trazabilidad. 
# Esto permite focalizar el análisis exploratorio sin perder reproducibilidad,
# ya que el dataset completo se conserva en data/clean.
datos_limpios <- readRDS(file.path(dir_data_clean, "datos_limpios.rds"))
datos_reducidos <- select(datos_limpios, order_id, profit, discount, region, segment, category)

# Guardar dataset reducido para análisis posteriores
saveRDS(datos_reducidos, file.path("data/processed", "datos_reducidos.rds"))
readr::write_csv(datos_reducidos, file.path("data/processed", "datos_reducidos.csv"))

mensaje_exito("Dataset reducido guardado en carpeta processed")
# -----------------------------------------------------------------------------
# CHEQUEOS EXPLORATORIOS INICIALES
# -----------------------------------------------------------------------------

mensaje_proceso("Tipos de variables por columna")
print(sapply(datos_reducidos, class))

mensaje_proceso("Cantidad de valores únicos por columna")
print(sapply(datos_reducidos, function(x) length(unique(x))))

mensaje_proceso("Resumen estadístico general")
write.csv(summary(datos_reducidos), file.path(dir_output_tables, "summary_reducidos.csv"))
print(summary(datos_reducidos))

# -----------------------------------------------------------------------------------------
# HIPÓTESIS PRINCIPAL: Se quiere testear si existe relación entre descuento y la rentabilidad
# -----------------------------------------------------------------------------------------

# Estadísticas básicas
summary(datos_reducidos$discount)
summary(datos_reducidos$profit)

# Correlación simple
cor_total_coef<-cor(datos_reducidos$discount, datos_reducidos$profit, use = "complete.obs")
print(cor_total_coef)

# Gráfico con todos los datos
corr_total <- ggplot(datos_reducidos, aes(x = discount, y = profit)) +
  geom_point(alpha = 0.4, color = colores_proyecto["primario"], size = 1.8) +
  geom_smooth(method = "lm", se = TRUE, color = colores_proyecto["secundario"], linewidth = 1) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_y_continuous(labels = scales::dollar_format(accuracy = 1)) +
  labs(
    title = "Total de observaciones",
    subtitle = paste("r ≈", round(cor_total_coef, 2)),
    x = "Descuento aplicado (%)",
    y = "Ganancia (USD)",
  ) +
  tema_proyecto() +
  theme(
    plot.title = element_text(hjust = 0, face = "bold", size = 16),
    plot.subtitle = element_text(face = "plain", size = 14),
    plot.caption = element_text(size = 9, face = "italic")
  )
# ---------------------------------------------------------------------------------
# DETECCIÓN DE OUTLIERS EN PROFIT 
# ---------------------------------------------------------------------------------

info_outliers <- detectar_atipicos(datos_reducidos, "profit")
datos_outliers <- datos_reducidos[datos_reducidos$profit %in% info_outliers$valores, ]
datos_no_outliers <- datos_reducidos[!(datos_reducidos$profit %in% info_outliers$valores), ]

cat("Cantidad de outliers detectados:", info_outliers$cantidad, "\n")
cat("Porcentaje sobre total:", round(info_outliers$porcentaje, 2), "%\n")

# Comparación de descuentos promedio
mean(datos_outliers$discount)
mean(datos_no_outliers$discount)

# Estadísticas comparadas
summary(datos_outliers$profit)
summary(datos_no_outliers$profit)

# Correlación sin outliers
corr_sin_outliers_coef <- cor(datos_no_outliers$discount, datos_no_outliers$profit, use = "complete.obs")
print(corr_sin_outliers_coef)

# Gráfico sin outliers
corr_sin_outliers <- ggplot(datos_no_outliers, aes(x = discount, y = profit)) +
  geom_point(alpha = 0.4, color = colores_proyecto["primario"], size = 1.8) +
  geom_smooth(method = "lm", se = TRUE, color = colores_proyecto["secundario"], linewidth = 1) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_y_continuous(labels = scales::dollar_format(accuracy = 1)) +
  labs(
    title = "Observaciones sin outliers",
    subtitle = paste("r ≈", round(corr_sin_outliers_coef, 2)),
    x = "Descuento aplicado (%)",
    y = "Ganancia (USD)",
  ) +
  tema_proyecto() +
  theme(
    plot.title = element_text(hjust = 0, face = "bold", size = 16),
    plot.subtitle = element_text(face = "plain", size = 14),
    plot.caption = element_text(size = 9, face = "italic")
  )

# ----------------------------------------------------------------------------- 
# VISUALIZACIÓN COMPARATIVA CON PATCHWORK
# -----------------------------------------------------------------------------

grafico_comparativo <- (corr_total / corr_sin_outliers) + plot_annotation(
  title = "¿La Ganancia Se Ve Afectada por el Nivel de Descuento?",
  subtitle = "Correlación entre las variables Profit y Discount. Evaluación del impacto de Outliers.",
  caption = "Fuente: Sample - Superstore",
  theme = theme(
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(face = "plain", size = 12),
    plot.caption = element_text(size = 9, face = "italic")
  )
)

guardar_grafico(grafico_comparativo, "correlacion_con_sin_outliers")
print(grafico_comparativo)

# -----------------------------------------------------------------------------------
# ANÁLISIS DE OUTLIERS POR VARIABLES PARA IDENTIFICAR PATRONES DE COMPORTAMIENTO
# -----------------------------------------------------------------------------------

# --- Categoría ---
prop_outliers_cat <- table(datos_outliers$category) / table(datos_reducidos$category) * 100
guardar_tabla(prop_outliers_cat, "outliers_by_category")
print(prop_outliers_cat)

# --- Región ---
prop_outliers_reg <- table(datos_outliers$region) / table(datos_reducidos$region) * 100
guardar_tabla(prop_outliers_reg, "outliers_by_region")
print(prop_outliers_reg)

# --- Segmento ---
prop_outliers_seg <- table(datos_outliers$segment) / table(datos_reducidos$segment) * 100
print(prop_outliers_seg)
guardar_tabla(prop_outliers_seg, "outliers_by_segment")

# -----------------------------------------------------------------------------------
# TABLA UNIFICADA DE OUTLIERS POR VARIABLE
# -----------------------------------------------------------------------------------
# Función auxiliar para contar outliers vs no outliers por variable
contar_outliers <- function(var){
  tibble(
    variable = var,
    categoria = datos_reducidos[[var]],
    estado = ifelse(datos_reducidos$profit %in% info_outliers$valores, "Outlier", "No Outlier")
  ) %>%
    count(variable, categoria, estado)
}

# Construir tablas por cada variable
tabla_cat <- contar_outliers("category")
tabla_reg <- contar_outliers("region")
tabla_seg <- contar_outliers("segment")

# Unir todo en una sola tabla
tabla_outliers <- bind_rows(tabla_cat, tabla_reg, tabla_seg)

# Guardar tabla unificada
guardar_tabla(tabla_outliers, "outliers_unificado")
print(head(tabla_outliers))

# --------------------------------------------------------
# GRÁFICO COMPARATIVO - PORCENTAJE DE OUTLIERS POR VARIABLE
# --------------------------------------------------------
# Calcular proporción de outliers por variable
tabla_prop <- tabla_outliers %>%
  group_by(variable, categoria) %>%
  mutate(prop = n / sum(n) * 100) %>%
  filter(estado == "Outlier") %>%
  mutate(variable = str_to_title(variable))   # Capitalizar primera letra

# Dot plot con porcentajes en eje Y
prop_outliers_total <- ggplot(tabla_prop, aes(x = categoria, y = prop, color = variable)) +
  geom_point(size = 4) +
  facet_wrap(~variable, scales = "free_x") +
  labs(
    title = "¿Dónde se concentran los Outliers de Profit?",
    subtitle = "Porcentaje de Outliers por cada Categoría, Región y Segmento",
    y = "Porcentaje de outliers"
  ) +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(family = "serif", face = "bold", size = 25, color = "#333333"),
    plot.subtitle = element_text(family = "serif", size = 20, color = "#333333"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    axis.title.y = element_text(family = "serif", margin = margin(r = 18)),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(family = "serif"),
    panel.grid.major.y = element_line(color = "gray80"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(hjust = 1, size = 20, family = "serif", face = "italic")
  )
print(prop_outliers_total)
# Recuadro para agregar al gráfico
recuadro <- ggplot() +
  annotate(
    "label",
    x = 0, y = 0,
    label = "Se evidencia una distribución desigual\ntanto en la variable \"Category\" como en \"Region\"",
    hjust = 0, vjust = 0,
    fill = "#D8ECFF",     
    color = "black",
    size = 4,            
    label.size = 0.4      
  ) +
  theme_void()

# Insertar recuadro 
prop_outliers_total_comparacion <- prop_outliers_total +
  inset_element(
    recuadro,
    left   = 0.20,  # más a la derecha
    bottom = 0.50,  # más arriba
    right  = 0.95,  # achicar ancho
    top    = 0.95,  # achicar altura
    align_to = "panel"
  )

print(prop_outliers_total_comparacion)

# Guardar el gráfico en PNG dentro de la carpeta output/figures
ggsave(
  filename = "output/figures/prop_outliers_total_comparacion.png",
  plot = prop_outliers_total_comparacion,
  width = 10, height = 8, dpi = 300
)