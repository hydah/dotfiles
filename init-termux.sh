#!/bin/sh

pkg install python python2
pkg install vim-python
pkg intall lua liblua-dev
pkg install neovim
pkg install clang libclang libllvm-dev lld llvm libllvm

cur_dir=`pwd`
ln -s $cur_dir/vim/.vimrc ~/.vimrc
ln -s $cur_dir/vim/.vim ~/.vim
ln -s $cur_dir/git/.gitconfig ~/.gitconfig
ln -s $cur_dir/shell/.bash_profile ~/.bash_profile

#for neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $cur_dir/neovim/.config ~/.config
ln -s $cur_dir/vim/.vimrc ~/.config/nvim/init.vim

cd ~
echo "source .bash_profile" >> ~/.bashrc
source .bashrc
