# TRABAJO FINAL - 2C2025 - GRUPO27
## Ciencia de Datos para Economía y Negocios
### Alumna: Lucía Piquero - 903431

---
## Encuadre
El siguiente trabajo aplica los contenidos de la materia "Ciencia de Datos para Economía y Negocios" de la Universidad de Buenos Aires.

El código que sustenta el trabajo fue desarrollado en **Rstudio**, por lo que se requiere de su instalación previo a ser replicado.  

En los próximos párrafos, el lector tendrá acceso a una guía descriptiva que facilitará el entendimiento del proyecto presentado.

## Síntesis
El trabajo consta de la formulación de una hipotesis falsable junto a su posterior análisis y desarrollo a partir de una base de datos seleccionada. 

El dataset seleccionado se compone por las **ventas y ganancias de un supermercado en los Estados Unidos**. 

-----
## FORMULACIÓN DE HIPÓTESIS 
La hipótesis principal plantea que los **Descuentos Afectan Negativamente la Rentabilidad del Negocio**:  
- A mayor descuento, menor profit esperado.  
- Se intuye que este efecto no es uniforme sino que puede verse influenciado por la **categoría del producto**, la **región geográfica** o el **segmento** al que pertenece el cliente.
  Por tanto, se espera encontrar diferencias significativas en el comportamiento de cada una de las variables señaladas.
------

## 00. Organización del Proyecto
Una vez seleccionada la base de datos, el primer paso implica generar un script inicial que configure el entorno global del proyecto y ordene las carpetas pertinentes.

A partir de este script se crean 4 carpetas en las que se dividirán los archivos del trabajo: **data - functions - output - scripts**.

En las carpetas mencionadas se guardan los siguientes archivos:

- **Data**: Datos crudos, limpios y procesados.

- **Functions**: Scripts de funciones predeterminadas que se usan a lo largo del proyecto.

- **Output**: Gráficos y tablas surgidas a partir del análisis del dataset.

- **Scripts**: Códigos ordenados cronológicamente que cubren los análisis requeridos a la hora de tratar el dataset.

---
## 01. Carga de Datos
Una vez configurado el entorno global, se carga el dataset crudo para su posterior analísis en Rstudio. 

---
## 02. Limpieza
A partir de los datos crudos, se limpia de la totalidad de los datos. Se retoma a partir del archivo cargado en el script 01.

Con el fin de limpiar los datos, se analizan **valores faltantes, existencia de outliers y chequeos estructurales** del dataset (glimpse + skim).

Al finalizar el script se guardan los **datos limpios** en la carpeta correspondiente. 

----
## 03. EDA
Contando con los datos limpios, se explora el dataset en profundidad.
Para ello, se reducen los datos seleccionando unicamente las variables de interés en función de la hipótesis inicial.
Las variables de interés serán **Profit; Discount; Category; Region y Segment**, adicionalmente se selecciona la variable **"Order Id"** por motivos precautorios de trazabilidad. 

Se realiza una **correlación simple** entre las variables principales (Profit y Discount).

A su vez, se analiza la presencia de **Outliers**. 
Se detecta una fuerte presencia de outliers **(18%)** por lo que se comparan las estadisticas principales con y sin outliers.
Se evalúa el comportamiento de los outliers por Categoría, Región y Segmento a fin de tener una incipiente noción de su influencia previo al análisis final. 

Se decide **no eliminar los outliers** del total de los datos ya que representan una parte importante de ellos.
A partir de esta conclusión, en el Script 05 se analiza el comportamiento de los outliers como un grupo separado. 

----
## 04. Estadística Descriptiva
Teniendo un primer análisis del dataset, se continúa con un análisis de las principales medidas estadísticas de las variables de interés. 

Se estudian las medidas de **tendencia central y de dispersión** de las variables de principal relevancia (profit y discount).

Adicionalmente, se estudia la distribución de frecuencias de variables complementarias a la hipotesis principal.

Se desarrollan gráficos para visualizar las distintas tendencias estadísticas. 

---
## 05. Inferencia Estadística
Habiendo hecho un analisis exhaustivo de los datos, se testea la hipótesis planteada en un principio. 

Considerando la fuerte presencia de outliers, se corren tres **modelos de regresión** para cada escenario: 

1. Totalidad de los datos reducidos.
2. Datos reducidos sin outliers.
3. Solo outliers. 

Dados los resultados, se toma de referencia el segundo modelo (datos reducidos sin outliers) y se testea el cumplimiento de los supuestos de regresión. 
- Linealidad
- Homocedasticidad
- Normalidad
- Independencia
  
Paralelamente, se estudia si existe algún patrón en las variables complementarias (category,region, segment) que explique una mayor presencia de outliers. 
Para ello, se corre un test chi-cuadrado para cada una de las tres variables. 

Dados los resultados, se corre el modelo de regresión principal pero segmentandolo por cartegory y por region. 

Y por último se corre un modelo de ANOVA por cada uno de los dos modelos corridos en última instancia. 

---

## PRESENTACIÓN FINAL DEL TRABAJO
Dentro de este repositorio se encuentra un conjunto de diapostivas que resume los principales análisis y conclusiones obtenidos a paritr de los scripts desarrollados anteriornmente. 











