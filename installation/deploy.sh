#########################################################################
# File Name:deploy.sh
# Author:hey
#mail: hey@vmware..com
# Created Time:Fri 21 Aug 2015 01:20:27 AM PDT
#########################################################################
#!/bin/bash
source ./env-variable.sh
cur_dir=`pwd`
ln -s $root_dir/vim/.vimrc ~/.vimrc
ln -s $root_dir/vim/.vim ~/.vim
ln -s $root_dir/git/.gitconfig ~/.gitconfig
ln -s $root_dir/shell/.bash_profile ~/.bash_profile
#git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo mkdir /usr/share/fonts/consolas
sudo cp $root_dir/fonts/* /usr/share/fonts/consolas
cd /usr/share/fonts/consolas
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv

echo "source .bash_profile" >> ~/.bashrc
source ~/.bashrc

