# =============================================================================
# SCRIPT 05: INFERENCIA ESTADÍSTICA (simplificado con archivo sin outliers)
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero
# =============================================================================

# 1. Limpiar entorno
rm(list = ls())

# 2. Traer configuración global y funciones
source("scripts/00_organizacion_proyecto.R")
source("functions/00_funciones_carga.R")
source("functions/01_funciones_limpieza.R")
source("functions/02_funciones_visualizacion.R")
source("functions/03_funciones_tablas.R")

library(ggplot2)
library(dplyr)
library(broom)
library(lmtest)
library(sandwich)

# 3. Cargar dataset sin outliers (generado en Script 03/04)
datos_no_outliers <- readRDS(file.path("data/processed", "datos_no_outliers.rds"))

# ----------------------------------------------------------------------------- 
# MODELO PRINCIPAL: Relación entre descuento y rentabilidad
# -----------------------------------------------------------------------------
modelo_principal <- lm(profit ~ discount, data = datos_no_outliers)
summary(modelo_principal)

# ----------------------------------------------------------------------------- 
# VERIFICACIÓN DE SUPUESTOS
# -----------------------------------------------------------------------------
par(mfrow = c(2,2))
plot(modelo_principal)

# Media de residuos
mean(residuals(modelo_principal))

# Normalidad de residuos
set.seed(123)
shapiro.test(sample(residuals(modelo_principal), 500))

# Homoscedasticidad
bptest(modelo_principal)

# Errores robustos si hay heterocedasticidad
coeftest(modelo_principal, vcov = vcovHC(modelo_principal, type = "HC1"))

# ----------------------------------------------------------------------------- 
# TESTS DE INDEPENDENCIA (Chi-cuadrado)
# -----------------------------------------------------------------------------
chisq_cat <- chisq.test(table(datos_no_outliers$category, datos_no_outliers$profit > 0))
chisq_reg <- chisq.test(table(datos_no_outliers$region, datos_no_outliers$profit > 0))
chisq_seg <- chisq.test(table(datos_no_outliers$segment, datos_no_outliers$profit > 0))

resultados_chisq <- data.frame(
  variable = c("Category", "Region", "Segment"),
  estadistico = c(chisq_cat$statistic, chisq_reg$statistic, chisq_seg$statistic),
  p_value = c(chisq_cat$p.value, chisq_reg$p.value, chisq_seg$p.value)
)
guardar_tabla(resultados_chisq, "resultados_chisq_profit")
print(resultados_chisq)

# ----------------------------------------------------------------------------- 
# MODELO EXTENDIDO: Incluyendo variables relevantes
# -----------------------------------------------------------------------------
modelo_extendido <- lm(profit ~ discount + category + region, data = datos_no_outliers)
summary(modelo_extendido)

# ----------------------------------------------------------------------------- 
# MODELO EXTENDIDO: Incluyendo variables relevantes
# -----------------------------------------------------------------------------
modelo_extendido <- lm(profit ~ discount + category + region, data = datos_no_outliers)
summary(modelo_extendido)