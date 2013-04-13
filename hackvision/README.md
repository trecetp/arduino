# TVout y Hackvision

[Juegos](http://nootropicdesign.com/hackvision/games.html) y [salida de television](http://code.google.com/p/arduino-tvout/) para arduino.

### Instalación
<pre>
cd hackvision
sudo ./instalar.sh
</pre>

### Conexiones

![Conexiones](http://farm5.static.flickr.com/4087/5225072558_5f5f760037.jpg)

Dependiendo del micro las patas para el sincronismo, video y audio respectivamente

* **m168,m328** 9, 7 y 11
* **m1280,m2560** 11, A7(D29), 10
* **m644,m1284p** 13, A7(D24), 8

### Ejemplo

<pre>
hackvision/examples/TVout/DemoPAL/
arduino upload
</pre>

### Conectar el nunchuku

Para manejar la mayoria de los juegos se puede usar un nunchuku

![Nunchuku](http://electronicavm.files.wordpress.com/2012/03/nunchuck_plug1.jpg?w=400)

Data y Clock van al A4 y A5, GND y 3.3V a las patas del arduino con estas caracteristicas

## Fuente Bibliográfica

- http://code.google.com/p/arduino-tvout/
- http://nootropicdesign.com/hackvision/games.html
- http://electronicavm.wordpress.com/2012/03/29/wii-nunchuk-arduino/
- http://www.wayneandlayne.com/projects/video-game-shield/download/
