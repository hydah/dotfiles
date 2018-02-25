#!/bin/bash

source ../env-variable.sh
#install python
bash ./init-python3.sh
#install vim
bash ./init-vim.sh
#install neovim
bash ./init-neovim.sh


# 安装clang
sudo cat "[llvm]
name=LLVM for CentOS-$releasever
baseurl=https://llvm.cpp.fail/CentOS/$releasever/llvm/$basearch/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://llvm.cpp.fail/gpg.key" >  /etc/yum.repos.d/llvm.repo
sudo yum install clang clang-devel libc++ libc++-devel lld lldb lldb-devel llvm llvm-devel


su
# 安装go tools
sh ./init-go.sh

vim +PlugInstall +q
