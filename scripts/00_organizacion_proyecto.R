# =============================================================================
# SCRIPT 00: CONFIGURACIÓN GLOBAL DEL PROYECTO
# TP FINAL CDD 2C2025
# LUCÍA PIQUERO - 903431
# OUTPUTS: CARPETAS EN LAS QUE SE DIVIDIRÁ EL PROYECTO
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Configurar opciones globales
options(stringsAsFactors = FALSE)   # Evitar factores automáticos
options(scipen = 999)               # Evitar notación científica

# 3. Librerías del proyecto
library(tidyverse)
library(readxl)
library(lubridate)
library(scales)
library(here)   # para rutas reproducibles

here() # verificar el directorio
# 4. Definir directorio raíz del proyecto
if (!exists("proyecto_dir")) {
  proyecto_dir <- here::here()  # Usa el .Rproj como raíz
}


# 5. Rutas principales
dir_data_raw       <- file.path(proyecto_dir, "data", "raw")
dir_data_clean     <- file.path(proyecto_dir, "data", "clean")
dir_data_processed <- file.path(proyecto_dir, "data", "processed")
dir_output_figures<- file.path(proyecto_dir, "output", "figures")
dir_output_tables <- file.path(proyecto_dir, "output", "tables")
dir_scripts <- file.path(proyecto_dir, "scripts")
dir_functions <-file.path(proyecto_dir,"functions")

# 6. Crear directorios si no existen
dirs_crear <- c(dir_data_raw, dir_data_clean, dir_data_processed,
                dir_output_figures, dir_output_tables, dir_scripts
                ,dir_functions)

for (dir in dirs_crear) {
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  }
}
