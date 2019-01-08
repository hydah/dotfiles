#!/bin/bash
source ../env-variable.sh

sudo apt-get install build-essential
sudo apt-get install ruby libperl-dev python-dev ruby-dev ncurses-dev

sudo apt remove vim

pushd $PKG_DIR
#git clone https://github.com/vim/vim.git --depth=1 && cd vim/
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar xf vim-8.0.tar.bz2
cd vim80
./configure --with-features=huge --enable-multibyte  --with-tlib=tinfo  --enable-python3interp --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-multibyte --enable-cscope
make -j8 && sudo make install
popd

rm -rf ~/.vimrc
rm -rf ~/.vim
ln -s $root_dir/vim/.vimrc ~/.vimrc
ln -s $root_dir/vim/.vim ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

