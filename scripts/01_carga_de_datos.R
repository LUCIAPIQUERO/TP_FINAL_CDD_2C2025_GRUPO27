# =============================================================================
# SCRIPT 01: CARGA DE DATOS CRUDOS Y CHEQUEOS INICIALES
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero - 903431
# OUTPUTS: data/clean/datos_clean.csv + datos_clean.rds
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Traer la organización del proyecto (script 00)
source("scripts/00_organizacion_proyecto.R")

# 3. Cargar librerías adicionales
library(janitor)   # limpieza de nombres de columnas
library(skimr)     # resumen rápido del dataset

# 4. Traer funciones de carga/guardado
source("functions/00_funciones_carga.R")

# 5. Carga de datos desde carpeta raw
datos_raw <- cargar_datos("Sample - Superstore.csv", carpeta = "raw")