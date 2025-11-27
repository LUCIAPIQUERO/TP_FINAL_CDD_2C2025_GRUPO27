# =============================================================================
# FUNCIONES PARA GUARDAR TABLAS
# =============================================================================

#' Guardar tabla en CSV
#' @param tabla objeto tipo table o data.frame
#' @param nombre nombre del archivo sin extensión
#' @param con_fecha lógico, TRUE si se quiere anteponer la fecha al nombre
#' @param formato_fecha formato de la fecha (por defecto YYYYMMDD)
guardar_tabla <- function(tabla, nombre, con_fecha = TRUE, formato_fecha = "%Y%m%d") {
  
  # Convertir a data.frame si es table
  if (is.table(tabla)) {
    tabla <- as.data.frame(tabla)
  }
  
  # Construir nombre de archivo
  if (con_fecha) {
    fecha_actual <- format(Sys.Date(), formato_fecha)
    nombre_completo <- paste0(fecha_actual, "_", nombre, ".csv")
  } else {
    nombre_completo <- paste0(nombre, ".csv")
  }
  
  # Guardar archivo en carpeta de output
  write.csv(tabla, file = file.path(dir_output_tables, nombre_completo), row.names = FALSE)
  
  # Mensaje de confirmación
  mensaje_exito(paste("Tabla guardada:", nombre_completo))
}