#!/bin/bash

#
# create an INIDgent disk image from a Raspeberry Pi OS lite (32)
#

# Download and flash "Raspberry Pi OS Lite 32 bits" on a 8GB sd card
#
#        * with pi imager :
#                - hostname : indigent
#                - user : indi
#                - passwd : indi
#                - enable SSH
#                - enable wifi client

# Login with ssh indi@indigent, and with raspi-config
#
#        * disable OneWire, I2C, etc.
#        * switch video RAM to 16MB (smallest amount)
#
#        locales :
#
#        * GB UTF8
#        * FR UTF8
#
#        * sudo apt update
#        * sudo apt upgrade
#
#        reboot

# Get the indigent install script and start it:
#
#        * wget <TODO>
#        * cd indigent; sudo ./configure.sh
#

# add INDIgent repo and install packages
cp INDIgent.list /etc/apt/sources.list.d/
apt update
apt install libindi1 libindi-data indi-bin indi-eqmod indi-sx indi-sbig indi-apogee indi-gphoto indi-qsi indi-fishcamp indi-maxdomeii indi-asi indi-aagcloudwatcher-ng indi-ffmv indi-dsi indi-qhy indi-gpsd indi-mi indi-duino indi-fli indi-nexdome indi-gpsnmea indi-armadillo-platypus indi-mgen indi-shelyak indi-nightscape indi-toupbase indi-atik indi-avalon indi-starbook indi-starbook-ten indi-astromechfoc indi-dreamfocuser indi-aok indi-talon6 indi-pentax indi-celestronaux indi-svbony indi-bresserexos2 indi-playerone indi-beefocus indi-weewx-json

# install indi web manager
apt-get install python3-pip
pip3 install indiweb
cp indiwebmanager.service /etc/systemd/system/
chmod 644 /etc/systemd/system/indiwebmanager.service
systemctl daemon-reload
systemctl enable indiwebmanager
systemctl start indiwebmanager

# creat hotspot
apt-get install hostapd
apt-get install dnsmasq
systemctl stop hostapd
systemctl stop dnsmasq

cat "" >> /etc/dhcpcd.conf
cat "interface wlan0" >> /etc/dhcpcd.conf
cat "nohook wpa_supplicant" >> /etc/dhcpcd.conf
cat "static ip_address=192.168.0.10/24" >> /etc/dhcpcd.conf

mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cp dnsmasq.conf /etc/
cp hostapd.conf /etc/hostapd/
cat "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" > /etc/default/hostapd

systemctl enable dnsmasq
systemctl start dnsmasq
systemctl stop wpa_supplicant
systemctl disable wpa_supplicant
systemctl unmask hostapd
systemctl enable hostapd
systemctl start hostapd


