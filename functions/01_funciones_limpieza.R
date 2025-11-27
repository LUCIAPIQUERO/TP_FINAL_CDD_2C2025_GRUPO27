# =============================================================================
# FUNCIONES PARA LIMPIEZA DE DATOS
# =============================================================================

#' Limpiar nombres de columnas según convenciones del proyecto
#' @param df data.frame con nombres a limpiar
#' @return data.frame con nombres en snake_case
limpiar_nombres <- function(df) {
  nombres_nuevos <- names(df) %>%
    str_to_lower() %>%                    # Todo minúsculas
    str_replace_all("[^a-zA-Z0-9_]", "_") %>%  # Solo letras, números y _
    str_replace_all("_{2,}", "_") %>%     # Eliminar _ múltiples
    str_remove("^_|_$")                   # Eliminar _ al inicio/final
  
  names(df) <- nombres_nuevos
  return(df)
}

#' Validar rangos de variables numéricas
#' @param vector vector numérico a validar
#' @param min_val valor mínimo esperado
#' @param max_val valor máximo esperado
#' @return logical vector indicando valores válidos
validar_rango <- function(vector, min_val = -Inf, max_val = Inf) {
  vector >= min_val & vector <= max_val & !is.na(vector)
}

#' Detectar y reportar datos atípicos usando IQR
#' @param df data.frame
#' @param columna nombre de la columna a analizar
#' @return lista con información sobre atípicos
detectar_atipicos <- function(df, variable) {
  x <- df[[variable]]
  x <- x[!is.na(x)]  # eliminar NAs
  
  # Cálculo de límites usando IQR
  Q1 <- quantile(x, 0.25)
  Q3 <- quantile(x, 0.75)
  IQR <- Q3 - Q1
  lim_inf <- Q1 - 1.5 * IQR
  lim_sup <- Q3 + 1.5 * IQR
  
  # Detección de outliers
  outliers <- x[x < lim_inf | x > lim_sup]
  cantidad <- length(outliers)
  porcentaje <- 100 * cantidad / length(x)
  
  # Output como lista
  return(list(
    cantidad = cantidad,
    porcentaje = porcentaje,
    limites = c(inferior = lim_inf, superior = lim_sup),
    valores = outliers
  ))
}