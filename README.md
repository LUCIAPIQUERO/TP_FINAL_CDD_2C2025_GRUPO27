# TRABAJO FINAL - 2C2025 - GRUPO27
## Ciencia de Datos para Economía y Negocios
### Alumna: Lucía Piquero - 903431

---
## Encuadre
El presente trabajo integra los contenidos de la materia "Ciencia de Datos para Economía y Negocios" de la Universidad de Buenos Aires.

El código que sustenta el trabajo fue desarrollado en **RStudio**, por lo que se requiere de su instalación previo a ser replicado.  

El código utiliza la función "here" por lo que el código está pensado para usarse como un  **RStudio Project (.Rproj)**. 

Este documento ofrece una guía descriptiva que facilita la comprensión del proyecto.

## Síntesis
El trabajo consta de la formulación de una hipótesis falsable junto a su posterior análisis y desarrollo a partir de una base de datos seleccionada. 

El dataset seleccionado se compone por las **ventas y ganancias de un supermercado en los Estados Unidos**. 

-----
## FORMULACIÓN DE HIPÓTESIS 
La hipótesis central es que los **Descuentos Reducen Significativamente la Ganancia**. 
Este efecto se espera heterogéneo según **categoría de producto, región y segmento de cliente**.
- A mayor descuento, menor profit esperado.  
- Se intuye que este efecto no es uniforme sino que puede verse influenciado por la **categoría del producto**, la **región geográfica** o el **segmento** al que pertenece el cliente.
  Por tanto, se espera encontrar diferencias significativas en el comportamiento de cada una de las variables señaladas.
------

## 00. Organización del Proyecto
Una vez seleccionada la base de datos, el primer paso implica generar un script inicial que configure el entorno global del proyecto y ordene las carpetas pertinentes.

A partir de este script se crean 4 carpetas en las que se dividirán los archivos del trabajo: **data - functions - output - scripts**.

En las carpetas mencionadas se guardan los siguientes archivos:

| Carpeta    | Contenido |
|------------|-----------|
| **data**   | Datos crudos, limpios y procesados |
| **functions** | Scripts de funciones auxiliares reutilizables |
| **output** | Gráficos y tablas del análisis |
| **scripts** | Códigos ordenados cronológicamente y segmentados según su utilidad |

### A su vez, el contenido del proyecto se divide en los siguientes scripts: 

| Script | Contenido principal |
|--------|---------------------|
| **00** | Configuración global y organización de carpetas |
| **01** | Carga de datos crudos |
| **02** | Limpieza de datos: renombrado, valores faltantes, outliers |
| **03** | Análisis exploratorio (EDA) y correlaciones |
| **04** | Estadística descriptiva y visualizaciones |
| **05** | Inferencia estadística: regresiones, supuestos y segmentaciones |

---
## 01. Carga de Datos
Una vez configurado el entorno global, se carga el dataset crudo para su posterior análisis en Rstudio. 

---
## 02. Limpieza
A partir de los datos crudos, se realiza la limpieza del dataset, analizando **valores faltantes, outliers y estructura**.

Al finalizar el script se guardan los **datos limpios** en la carpeta correspondiente. 

----
## 03. EDA
Contando con los datos limpios, se explora el dataset en profundidad.
Para ello, se reducen los datos seleccionando únicamente las variables de interés en función de la hipótesis inicial.
Las variables de interés serán **Profit; Discount; Category; Region y Segment**, adicionalmente se selecciona la variable **"Order Id"** por motivos precautorios de trazabilidad. 

Se realiza una **correlación simple** entre las variables principales (Profit y Discount).

A su vez, se analiza la presencia de **Outliers**. 
Se detecta una fuerte presencia de outliers **(18%)** por lo que se comparan las estadísticas principales con y sin outliers.
Se evalúa el comportamiento de los outliers por Categoría, Región y Segmento a fin de tener una incipiente noción de su influencia previo al análisis final. 


----
## 04. Estadística Descriptiva
Teniendo un primer análisis del dataset, se continúa con un análisis de las principales medidas estadísticas de las variables de interés. 

Se estudian las medidas de **tendencia central y de dispersión** de las variables de principal relevancia (profit y discount).

Adicionalmente, se estudia la distribución de frecuencias de variables complementarias a la hipótesis principal.

Se desarrollan gráficos para visualizar las distintas tendencias estadísticas. 

---
## 05. Inferencia Estadística
Habiendo hecho un análisis exhaustivo de los datos, se testea la hipótesis planteada en un principio. 

Previo a ello, se decide eliminar los outliers para analizar el coportamiento más representativo de la muestra. 

Dados los resultados, se testea el cumplimiento de los supuestos de regresión. 

- Linealidad
- Homocedasticidad
- Normalidad
- Independencia
  
Paralelamente, se estudia si existe dependencia significativa de la variable profit para con alguna de las variables complementarias (categoría, region, segmento).  
Para ello, se corre un test chi-cuadrado para cada una de las tres variables. 

Dados los resultados, se concluye que tanto "Category" como "Region" rechazan H0. 

Se corre el modelo de regresión principal pero segmentándolo por categoría y por región. 

---

## PRESENTACIÓN FINAL DEL TRABAJO
El repositorio incluye una presentación compuesta por diapositivas que sintetizan los principales hallazgos y conclusiones del proyecto.









