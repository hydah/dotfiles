#!/bin/bash

source ../env-variable.sh
#install python3.6
pushd  $PKG_DIR
sudo apt-get install zlib1g-dev openssl
#sudo sudo yum install -y openssl-static

wget http://python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz
tar xf Python-3.6.1.tar.xz
cd Python-3.6.1
./configure --prefix=/usr/local/python3
make -j8
sudo make install
sudo ln -s /usr/local/python3/bin/python3 /usr/bin/python3
sudo ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
popd
