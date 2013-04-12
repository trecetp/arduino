Arduino
=======

Arduino con filosofia unix. 

- Portable a otros microprocesadores.
- Sin usar el IDE de arduino.
- Sin usar java

## Instalación

`sudo ./instalar.sh`

## Ejemplo
compilar y cargar al arduino

<pre>
cd arscons
arduino upload
</pre>


## Nota

- El ejemplo esta pensado para el `atmega328` hay que cambiar la configuración para otro modelo de arduino, en `share/arduino/SConstruct`
- Solo probado en GNU/Linux

## Fuente Bibliografica

- http://syvic.synusia.es/node/7
