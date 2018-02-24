source env-variable.sh
#for neovim
sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
pushd $PKG_DIR
git clone https://github.com/neovim/neovim.git
cd neovim
# Build
make
sudo make install
popd
# install python3 first
sudo pip3 install neovim

ln -s $cur_dir/neovim/.config ~/.config
ln -s $cur_dir/vim/.vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
