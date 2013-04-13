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

## Ejemplos
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

actualmente están incluidas las sintaxis para emacs, gedit y vim, faltan para nano

## TVout y Hackvision

[Juegos](http://nootropicdesign.com/hackvision/games.html) y [salida de television](http://code.google.com/p/arduino-tvout/) para arduino.

![Conexiones](http://farm5.static.flickr.com/4087/5225072558_5f5f760037.jpg)

<pre>
cd hackvision
sudo ./instalar.sh
</pre>

### Conectar el nunchuku

Para manejar la mayoria de los juegos se puede usar un nunchuku

![Nunchuku](http://electronicavm.files.wordpress.com/2012/03/nunchuck_plug1.jpg?w=400)

Data y Clock van al A4 y A5, GND y 3.3V a las patas del arduino con estas caracteristicas

## Nota

- El ejemplo esta pensado para el `atmega328` hay que cambiar la configuración para otro modelo de arduino, en `share/arduino/SConstruct`
- Solo probado en GNU/Linux

## Fuente Bibliográfica

- http://syvic.synusia.es/node/7
- http://blog.nemik.net/2011/12/arduino-openwrt-art/
- http://code.google.com/p/arduino-tvout/
- http://nootropicdesign.com/hackvision/games.html
- http://electronicavm.wordpress.com/2012/03/29/wii-nunchuk-arduino/
