#!/bin/sh

aptitude install scons python-serial avr-libc
cp -r share/arduino /usr/share/arduino
cp bin/arduino /usr/bin/
