#########################################################################
# File Name:deploy.sh
# Author:hey
#mail: hey@vmware..com
# Created Time:Fri 21 Aug 2015 01:20:27 AM PDT
#########################################################################
#!/bin/bash
cur_dir=`pwd`
ln -s $cur_dir/vim/.vimrc ~/.vimrc
ln -s $cur_dir/vim/.vim ~/.vim
ln -s $cur_dir/git/.gitconfig ~/.gitconfig
ln -s $cur_dir/shell/.bash_profile ~/.bash_profile
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

