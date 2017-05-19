#!/bin/bash

rm ~/.vimrc
rm ~/.vim -rf
ln -s `pwd`/.vimrc ~
ln -s `pwd`/.vim ~
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
