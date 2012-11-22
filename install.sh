#!/bin/sh
set -x -e

# AMOS needs mummer for some of its utils
# use era7bio/mummer.install if needed

cd /opt
wget http://sourceforge.net/projects/amos/files/amos/3.1.0/amos-3.1.0.tar.gz/download
tar -xvzf amos-3.1.0.tar.gz
rm amos-3.1.0.tar.gz
cd amos-3.1.0

# deps
yum -y install make gcc zlib zlib-devel zlib-static boost boost-devel \
  libXmu libXmu-devel libXi libXi-devel expat expat-devel \
  perl perl-ExtUtils-* \

# install cpanm
curl -L http://cpanmin.us | perl - App::cpanminus
# add perl mods
/usr/local/bin/cpanm Statistics::Descriptive DBI

# configure AMOS
./configure --prefix=/opt/amos-3.1.0
make
make install
# create links for binaries
ln -s /opt/amos-3.1.0/bin/* /usr/bin
