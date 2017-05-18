#!/bin/sh

sudo apt-get source linux-image-$(uname -r)
sudo apt-get build-dep linux-image-$(uname -r)
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
   libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
   libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
   python3-dev ruby-dev lua5.3 liblua5.3-dev libperl-dev git

# for vim
sudo ln -s /usr/include/lua5.3 /usr/include/lua
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/local/lib/liblua.so
sudo apt-get remove vim vim-runtime vim-tiny vim-common
pushd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-python3interp --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-multibyte --enable-cscope
make -j8 && sudo make install
popd

# for python
pushd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip install jedi
