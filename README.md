Arduino
=======

Arduino con filosofia unix. 

- Portable a otros micros
- Sin usar el IDE de arduino.
- Sin usar java

## Instalación

requiere pyserial, scons

`aptitude install scons python-serial`

### Copiar los archivos compartidos de arduino

<pre>
sudo mkdir -p /usr/share/arduino
cd /usr/share/arduino
wget http://arduino.googlecode.com/files/arduino-1.0.4-linux32.tgz -O - | tar -zxf -
wget https://raw.github.com/b4zz4/arduino/master/SConstruct
mv arduino-1.0.4/* ..
rm -r arduino-1.0.4
</pre>

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
