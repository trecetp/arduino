Arduino (con filosofía Unix)
============================

- Sin usar el IDE de arduino.
- Sin usar java.
- Portable a otros microprocesadores.

## Instalación

`sudo ./instalar.sh`

## compilar y cargar al arduino

<pre>
cd Proyecto
arduino upload
</pre>

### Ejemplos
Leer cada archivo para ver como hay que conectar los led y sensores

<pre>
cd share/arduino/examples/01.Basics/Blink/
arduino upload
</pre>

### Serial

<pre>
cd share/examples/01.Basics/AnalogReadSerial
arduino upload
</pre>

Luego poner en la terminar de GNU/Linux

`stty -F /dev/ttyUSB0 raw speed 9600`

### Recibir mensajes

`cat /dev/ttyUSB0`
### Enviar mensajes

`echo "hello world" > /dev/ttyUSB0`

## Sintaxis

actualmente están incluidas las sintaxis para emacs, gedit, vim y otros. Faltan para nano

## Nota

- El ejemplo esta pensado para el `atmega328` hay que cambiar la configuración para otro modelo de arduino, en `share/arduino/SConstruct`
- Solo probado en GNU/Linux

## Fuente Bibliográfica

- http://syvic.synusia.es/node/7
- http://blog.nemik.net/2011/12/arduino-openwrt-art/

