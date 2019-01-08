#!/bin/bash
source ../env-variable.sh
#for neovim
sudo apt-get install build-essential
#sudo apt install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
pushd $PKG_DIR
git clone https://github.com/neovim/neovim.git
cd neovim
# Build
make
sudo make install
popd
# install python3 first
sudo pip3 install neovim

mkdir ~/.config
rm -rf ~/.config/nvim
ln -s $cur_dir/neovim/.config/nvim ~/.config/nvim
ln -s $cur_dir/vim/.vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
