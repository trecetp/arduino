Arduino
=======

Arduino con filosofia unix. 

- Portable a otros micros
- Sin usar el IDE de arduino.
- Sin usar java

## Instalación

requiere pyserial, scons

sudo ./instalar.sh

## compilar y cargar al arduino

<pre>
scons --sconstruct=/usr/share/arduino/SConstruct
scons --sconstruct=/usr/share/arduino/SConstruct upload
</pre>

## Nota

- voy a simplicar este tutorial con un instalador :D
- el ejemplo esta pensado para el `atmega328` hay que cambiar la configuración para otros micros.

## Fuente Bibliografica

- http://syvic.synusia.es/node/7
