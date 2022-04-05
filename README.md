# Apps para manejo de datos de dispositivos de seguimiento GPS del ganado

Este repositorio contiene varios scripts y aplicaciones para manejar y transformar datos de seguimiento de GPS del ganado. Se han desarrollado por el [SERPAM](https://www.eez.csic.es/es/evaluacion-restauracion-y-proteccion-de-agrosistemas-mediterraneos-serpam) ***Servicio de Evaluación, Restauración y Protección de Agrosistemas Mediterráneos*** de la Estación Experimental del Zaidin del CSIC (EEZ-CSIC) en el contexto del proyecto [SUMHAL](https://lifewatcheric-sumhal.csic.es/), **Sustainability for Mediterraean Hospost integrating LifeWatch ERIC**. 

## Utilización

Para utilizar las aplicaciones es necesario el uso de R. Se recomienda utilizar R-Studio. Una vez en R, es necesario descargarte el [repositorio](https://github.com/serpam/convertGPS_cattle/archive/refs/heads/main.zip), descomprimir el archivo y abrir el proyecto. Para esto último es necesario abrir el archivo `convertGPS_cattle.Rproj`. 

## Conversión de archivos

Esta aplicación realiza la conversión de archivos descargados de los dispositivos GPS de medición contínua en un formato adecuado para su tratamiento. Para ejecutar la aplicación puedes abrir el archivo `scripts/run_convertidor.R` y ejecutarlo. También puedes ejecutar en la consola:

```r
source("scripts/run_convertidor.R") 
```

## Combinar y explorar archivos de dispositivos GPS

Esta aplicación permite realizar varias operaciones sobre los archivos de los dispositivos GPS. En concreto: 

- Combinar varios archivos para su descarga como csv
- Explorar fecha de incio, fin, número de registros, etc. 
- Explorar gráficamente la cantidad de registros para cada una de las fechas. 

Para ejecutar la aplicación puedes abrir el archivo `scripts/run_combina.R` y ejecutarlo. También puedes ejecutar en la consola:

```r
source("scripts/run_combina.R") 
```

## Versión
Estas aplicaciones están en desarrollo, para cualquier duda, sugerencia o mejora, puedes abrir un [issue](https://github.com/serpam/convertGPS_cattle/issues), o contactarnos directamente. 

Autores: 
- [Antonio J. Pérez-Luque](https://github.com/ajpelu)
- Mauro Tognetti Barbieri

