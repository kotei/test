#!/bin/sh

#mount base as read writemount -uw /base
mount -uw /base
 
cp /display/480p/display.conf	/base/etc/system/config/display.conf
cp /display/480p/graphics.conf	/base/etc/system/config/graphics.conf
cp /display/480p/scaling.conf	/base/etc/system/config/scaling.conf
cp /display/480p/car-startup.png	/base/usr/share/images/car-startup.png

rm /var/etc/system/config/calib.localhost

echo 'Change 480p done!'
