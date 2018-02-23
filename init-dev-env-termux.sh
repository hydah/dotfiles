#!/bin/sh

pkg install python python2
pkg install vim-python
pkg intall lua liblua-dev

cur_dir=`pwd`
ln -s $cur_dir/vim/.vimrc ~/.vimrc
ln -s $cur_dir/vim/.vim ~/.vim
ln -s $cur_dir/git/.gitconfig ~/.gitconfig
ln -s $cur_dir/shell/.bash_profile ~/.bash_profile
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#for neovim
ln -s $cur_dir/neovim/.config ~/.config
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~
echo "source .bash_profile" >> ~/.bashrc
source .bashrc
