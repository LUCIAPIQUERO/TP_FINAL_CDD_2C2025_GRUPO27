# =============================================================================
# FUNCIONES DE CARGA Y GUARDADO DE DATOS
# TP FINAL CDD 2C2025
# Autor: Lucía Piquero
# =============================================================================

# Mensajes de logging
mensaje_proceso <- function(texto) {
  cat("[INFO]", texto, "\n")
}

mensaje_exito <- function(texto) {
  cat("[OK]", texto, "\n")
}

#' Cargar datos con validación y logging
#' @param nombre_archivo nombre del archivo (ej: "Sample - Superstore.xlsx")
#' @param carpeta carpeta donde buscar ('raw' o 'processed')
#' @param encoding codificación del archivo (default: "UTF-8")
#' @return data.frame con los datos cargados
cargar_datos <- function(nombre_archivo, carpeta = "raw", encoding = "UTF-8") {
  
  # Construir ruta completa según carpeta
  ruta_carpeta <- switch(carpeta,
                         "raw"       = dir_data_raw,
                         "processed" = dir_data_processed,
                         stop("Carpeta debe ser 'raw' o 'processed'")
  )
  
  ruta_completa <- file.path(ruta_carpeta, nombre_archivo)
  
  # Validar existencia del archivo
  if (!file.exists(ruta_completa)) {
    stop("Archivo no encontrado: ", ruta_completa)
  }
  
  mensaje_proceso(paste("Cargando", nombre_archivo))
  
  # Detectar extensión y cargar
  extension <- tools::file_ext(nombre_archivo)
  
  datos <- switch(extension,
                  "csv"  = readr::read_csv(ruta_completa, locale = readr::locale(encoding = encoding)),
                  "xlsx" = readxl::read_excel(ruta_completa),
                  "rds"  = readRDS(ruta_completa),
                  "txt"  = readr::read_delim(ruta_completa, locale = readr::locale(encoding = encoding)),
                  stop("Formato no soportado: ", extension)
  )
  
  mensaje_exito(paste("Cargado:", nrow(datos), "filas,", ncol(datos), "columnas"))
  
  return(datos)
}

#' Guardar datos procesados con validación
#' @param datos data.frame a guardar
#' @param nombre_archivo nombre base sin extensión
guardar_datos_procesados <- function(datos, nombre_archivo) {
  
  # Timestamp para versionado
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M")
  nombre_completo <- paste0(timestamp, "_", nombre_archivo)
  
  # Rutas de salida
  ruta_csv <- file.path(dir_data_processed, paste0(nombre_completo, ".csv"))
  ruta_rds <- file.path(dir_data_processed, paste0(nombre_completo, ".rds"))
  
  # Guardar en múltiples formatos
  readr::write_csv(datos, ruta_csv)
  saveRDS(datos, ruta_rds)
  
  mensaje_exito(paste("Datos guardados:", nombre_completo))
  
  # Guardar metadatos
  metadatos <- list(
    fecha_creacion   = Sys.time(),
    filas            = nrow(datos),
    columnas         = ncol(datos),
    columnas_nombres = names(datos),
    archivo_origen   = nombre_archivo
  )
  
  saveRDS(metadatos, file.path(dir_data_processed, paste0(nombre_completo, "_metadata.rds")))
}