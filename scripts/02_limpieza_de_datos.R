# =============================================================================
# SCRIPT 02: LIMPIEZA DE DATOS
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero
# OUTPUTS: data/clean/datos_limpios.csv + datos_limpios.rds
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Traer configuración global
source("scripts/00_organizacion_proyecto.R")
source("scripts/01_carga_de_datos.R")

# 3. Traer funciones
source("functions/00_funciones_carga.R")
source("functions/01_funciones_limpieza.R")
source("functions/02_funciones_visualizacion.R")   # tema, colores, guardar_grafico
source("functions/03_funciones_tablas.R") 

# 5. Renombrar columnas para estandarizar
datos_clean <- janitor::clean_names(datos_raw)

# 6. Detección de valores faltantes
mensaje_proceso("Chequeo de valores faltantes")
faltantes <- colSums(is.na(datos_clean))
print(faltantes)
faltantes <- colSums(is.na(datos_clean))
tabla_faltantes <- data.frame(
  Variable = names(faltantes),
  Missing_Values = faltantes
)

guardar_tabla(tabla_faltantes, "missing_values")

# 7. Chequeos básicos de estructura
mensaje_proceso("Chequeos iniciales del dataset")
glimpse(datos_clean)
skim(datos_clean)

# 8. Validar rangos de variables numéricas (ejemplo: ventas >= 0)
validos_ventas <- validar_rango(datos_clean$sales, min_val = 0)
mensaje_proceso(paste("Registros inválidos en 'sales':", sum(!validos_ventas)))

# 9. Detección preliminar de outliers en la variable profit
info_atipicos <- detectar_atipicos(datos_clean, "profit")
mensaje_proceso(paste("Outliers detectados en 'profit':", info_atipicos$cantidad,
                      "(", round(info_atipicos$porcentaje, 2), "% )"))

# 10. Guardar dataset limpio final
readr::write_csv(datos_clean, file.path(dir_data_clean, "datos_limpios.csv"))
saveRDS(datos_clean, file.path(dir_data_clean, "datos_limpios.rds"))

mensaje_exito("Dataset limpio guardado en carpeta clean")
