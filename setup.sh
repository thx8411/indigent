#!/bin/bash


# install packages
sudo apt update
sudo apt-get -y install libnova-dev libcfitsio-dev libusb-1.0-0-dev zlib1g-dev libgsl-dev build-essential cmake git libjpeg-dev libcurl4-gnutls-dev libtiff-dev libfftw3-dev libftdi-dev libgps-dev libraw-dev libdc1394-22-dev libgphoto2-dev libboost-dev libboost-regex-dev librtlsdr-dev liblimesuite-dev libftdi1-dev libavcodec-dev libavdevice-dev libev-dev cdbs debhelper qtbase5-dev

sudo apt -y install libpigpiod-if-dev
sudo apt -y install libglib2.0-dev
sudo apt -y install libaravis-dev

# for libcamera, not ready yet
#sudo apt -y install libdrm-dev
#sudo apt -y install libcamera-dev
#sudo apt -y install libboost-program-options-dev
