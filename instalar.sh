#!/bin/sh

aptitude install scons python-serial avr-libc
cp -r share/arduino /usr/share/
cp bin/arduino /usr/bin/
