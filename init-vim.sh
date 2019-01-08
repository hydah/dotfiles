cur_dir=`pwd`
#for neovim
ln -s $cur_dir/neovim/.config ~/.config
ln -s $cur_dir/vim/.vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#for vim
ln -s $cur_dir/vim/.vimrc ~/.vimrc
ln -s $cur_dir/vim/.vim ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo yum remove vim

pushd ~/pkg
git clone https://github.com/vim/vim.git --depth=1 && cd vim/
./configure --with-features=huge --enable-multibyte  --with-tlib=tinfo  --enable-python3interp --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-multibyte --enable-cscope
make -j8 && sudo make install
popd
