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

El dataset seleccionado presenta **las ventas y ganancias de un supermercado de los Estados Unidos**. 

-----
## FORMULACIÓN DE HIPÓTESIS 
La hipótesis principal plantea que los **Descuentos Afectan Negativamente la Rentabilidad**:  
- A mayor descuento, menor profit esperado.  
- Este efecto no es uniforme, sino que depende de la **categoría de producto** y la **región geográfica**, donde se espera encontrar diferencias significativas en la magnitud de la relación.
------

## 00. Organización del Proyecto
Una vez seleccionada la base de datos, el primer paso implica generar un script inicial que configure el entorno global del proyecto y ordene las carpetas pertinentes.
-  \
A partir de este script se crean las 4 carpetas en las que se dividirán los archivos del trabajo: **data - functions - output - scripts**.
-  \
En las carpetas mencionadas se guardarán los siguientes archivos:
**Data**: Datos crudos, limpios y procesados.
**Functions**: Scripts de funciones predeterminadas que se usan a lo largo del proyecto.
**Output**: Gráficos y tablas que surgidas a partir del análisis del dataset.
**Scripts**: Códigos ordenados cronológicamente que abarcan los análisis requeridos a la hora de tratar el dataset.
---
## 01. Carga de Datos
-  \
Una vez configurado el entorno global, se procede a cargar el dataset crudo para su posterior analísis en Rstudio. 
---
## 02. Limpieza
-  \
A partir de los datos crudos, se continúa con una limpieza de la totalidad de los datos. Se retoma a partir del archivo cargado en el script 01.
Con el fin de limpiar los datos, se analizan valores faltantes, existencia de outliers y chequeos estructurales del dataset (glimpse + skim).
Al finalizar el script se guardarán los datos limpios en la carpeta correspondiente. 
----
## 03. EDA
-  \
Se procede a explorar el dataset limpio.
-  \
Se decide reducir los datos seleccionando unicamente las variables de interés en función de la hipótesis inicial.
Se estudian las características principales del dataset reducido. 
Luego se procede a realizar una correlación simple entre las variables principales (Profit y Discount).
A su vez, se analiza la presencia de Outliers. Se detecta una fuerte presencia de outliers (18%) por lo que se procede a comparar las estadisticas principales con y sin outliers. 
-  \
Las variables de interés serán **Profit; Discount; Category; Region y Segment**, adicionalmente se seleccionará la variable **"Order Id"** por motivos precautorios de trazabilidad. 
----
## 04. Estadística Descriptiva
-  \
Se estudian las medidas de tendencia central y de dispersión de las variables de principal relevancia (profit y discount).
A su vez se estudia la distribución de variables complementarias a la hipotesis principal.
Se desarrollan gráficos para visualizar las distintas tendencias estadísticas. 
---
## 05. Inferencia Estadística
Habiendo hecho un analisis exhaustivo de los datos, procedemos a correr el test planteado en un principio. 
Corremos tres modelos de regresión. Uno para el total de los datos relevantes, otro para los datos sin outliers y otro solo para los outliers. 

-  \
Luego, testeamos los supuestos de regresión...
-  \
Luego analizamos la dependendia de los outliers con las variables categoricas
-  \
EN funcion de eso corremos dos modelos segmentados y luego dos anova para testear supuestos.

---
## PRESENTACIÓN FINAL DEL TRABAJO
Dentro de este repositorio se podrá encontrar una presentación compuesta por diapositivas que tienen como fin explicitar las conclusiones relevantes del proyecto. 









