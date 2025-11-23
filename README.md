# TRABAJO FINAL - 2C2025 - GRUPO27
## Ciencia de Datos para Economía y Negocios
### Alumna: Lucía Piquero - 903431

---
## Encuadre
El siguiente trabajo tiene como objetivo la puesta en práctica de los contenidos vistos en la materia Ciencia de Datos para Economía y Negocios de la Universidad de Buenos Aires.

El código que sustenta el trabajo fue desarrollado en Rstudio, por lo que se requiere de su previa instalación antes de ser replicado.  

En los próximos párrafos, el lector tendrá acceso a una guía descriptiva que facilitará el entendimiento del proyecto presentado.

## Síntesis
El trabajo consiste primordialmente en la formulación de una hipotesis falsable junto a su posterior analisis y desarrollo a partir de una base de datos seleccionada. 

El dataset seleccionado contiene las ventas y ganancias de un determinado supermercado de los Estados Unidos. 

-----
## FORMULACIÓN DE HIPÓTESIS 
La hipótesis central del análisis es que los **descuentos afectan negativamente la rentabilidad**:  
- A mayor descuento, menor profit esperado.  
- Este efecto no es uniforme, sino que depende de la **categoría de producto** y la **región geográfica**, donde se espera encontrar diferencias significativas en la magnitud de la relación.
------

## 00. Organización del Proyecto
Una vez seleccionada la base de datos, el primer paso implica generar un script inicial que configure el entorno global del proyecto y ordene las carpetas pertinentes.

A partir de este script se crean las 4 carpetas en las que se dividirán los archivos del trabajo: **data - functions - output - scripts**. 

---
## 01. Carga de Datos
Una vez configurado el entorno global, se procede a cargar el dataset pertinente para su posterior analísis. 
---
## 02. Limpieza
Una vez cargado el dataset, se continúa con una limpieza inicial de la totalidad de los datos.
Para ello renombramos las variables y detectamos outliers. 
----
## 03. EDA
Luego de asegurarse que los datos se encuentran limpios, sin valores extraños, se procede a realizar un análisis exploratorio de datos más exhaustivo. 
En principio se seleccionan unicamente las variables de interes a partir de las cuales se desarrollará la hipótesis planteada en un principio. Ello se realiza para obtener medidas más concretas y útiles para el analísta. 
Las variables de interés serán "Profit; Discount; Category; Region y Segment", adicionalmente se seleccionará la variable "Order Id" por motivos precautorios de trazabilidad. 
----






