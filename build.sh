#!/bin/bash

#
# Build full INDI packages and publish
# needs a least 2GB of RAM (physical or swap)
#

mkdir packages

# fetch, build and install xisf
git clone https://gitea.nouspiro.space/nou/libXISF.git
cd libXISF
dpkg-buildpackage -b -us -uc
cd ..
sudo apt -y install ./libxisf_0.1.3-ubuntu1_armhf.deb
sudo apt -y install ./libxisf-dev_0.1.3-ubuntu1_armhf.deb
sudo apt -y install ./libxisf-dbgsym_0.1.3-ubuntu1_armhf.deb

mv *.deb packages

# fetch INDI sources
git clone --depth 1 --branch v2.0.0 https://github.com/indilib/indi.git

mkdir indi-build
# build INDI
cd indi-build
../indi/scripts/indi-core-deb.sh
cd build
mv *.deb ../../packages
cd ../../

# install INDI

cd packages
sudo apt -y install ./libindi-data_2.0.0_all.deb
sudo apt -y install ./indi-bin_2.0.0_armhf.deb ./libindi1_2.0.0_armhf.deb
sudo apt -y install ./libindi-dev_2.0.0_armhf.deb
sudo apt -y install ./indi-dbg_2.0.0_armhf.deb
cd ..

# fetch INDI 3rd party sources
git clone --depth 1 --branch v2.0.0 https://github.com/indilib/indi-3rdparty.git

mkdir indi-3rd-build
cd indi-3rd-build
# build INDI 3rd party libs
libraries=(
	libahp-gt
	libahp-xc
	libaltaircam
	libapogee
	libasi
	libatik
	libfishcamp
	libfli
	libinovasdk
	libmallincam
	libmicam
	libnncam
	libomegonprocam
	libpigpiod
	libpktriggercord
	libplayerone
	libqhy
	libqsi
	libricohcamerasdk
	libsbig
	libstarshootg
	libsvbony
	libtoupcam
)

for i in "${libraries[@]}"; do
    ../indi-3rdparty/scripts/indi-3rdparty-deb.sh "$i"
done

cp build/*.deb ../packages/

# install 3rd party libs

sudo apt -y install ./build/*.deb
rm -rf build
cd ..

# build INDI 3rd party drivers

drivers=(
	indi-aagcloudwatcher-ng
	indi-ahp-xc
	indi-aok
	indi-apogee
	indi-armadillo-platypus
	indi-asi
	indi-asi-power
	indi-astrolink4
	indi-astromechfoc
	indi-atik
	indi-avalon
	indi-beefocus
	indi-bresserexos2
	indi-celestronaux
	indi-dreamfocuser
	indi-dsi
	indi-duino
	indi-eqmod
	indi-ffmv
	indi-fishcamp
	indi-fli
	indi-gige
	indi-gphoto
	indi-gpsd
	indi-gpsnmea
	indi-inovaplx
	#indi-libcamera
	indi-limesdr
	indi-maxdomeii
	indi-mgen
	indi-mi
	indi-nexdome
	indi-nightscape
	#indi-nut
	indi-orion-ssg3
	indi-pentax
	indi-playerone
	indi-qhy
	indi-qsi
	#indi-rpicam
	indi-rpi-gpio
	indi-rtklib
	indi-sbig
	indi-shelyak
	indi-spectracyber
	indi-starbook
	indi-starbook-ten
	indi-svbony
	indi-sx
	indi-talon6
	indi-toupbase
	indi-webcam
	indi-weewx-json
)

cd indi-3rd-build

for i in "${drivers[@]}"; do
    ../indi-3rdparty/scripts/indi-3rdparty-deb.sh "$i"
done

cp build/*.deb ../packages/

# install INDI 3rd party drivers

sudo apt -y install ./build/*.deb
rm -rf build
cd ..

# testing

# TODO

# indexing packages

cd packages
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages
apt-ftparchive release . > Release

# publishing packages to repo

#
# to publish, execute "clean.sh", then "git add", "git commit" and "git push"
# the 'INDIgent.list' file must be updated with your repository url
#
