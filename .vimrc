" some statement
"	vim-scripts web page: http://vim-scripts.org/vim/scripts.html
"	vim.org/scripts: http://www.vim.org/scripts/index.php


" for vundle
set nocompatible " be iMproved
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" " required!
Bundle 'gmarik/vundle'

" " vim-scripts repos
"Bundle 'python.vim--Vasiliev'
Bundle 'a.vim'
Bundle 'taglist.vim'
Bundle 'winmanager'
Bundle 'grep.vim'
Bundle 'bufexplorer.zip'
" for python code syntax inspect
Bundle 'nvie/vim-flake8'
" for auto comment
Bundle 'scrooloose/nerdcommenter' 
"Bundle 'Valloric/YouCompleteMe'
Bundle 'tomasr/molokai'
Bundle 'nanotech/jellybeans.vim'

"
filetype plugin indent on    " required!

"=============================================================================
"============================================================================
set number
filetype on
set history=1000

syntax enable
syntax on

colorscheme jellybeans 
set t_Co=256

"let &termencoding=&encoding
"set fileencodings=utf-8,gbk

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set sts=4
"configure indent for python
autocmd FileType python setlocal et sta sw=4 sts=4
set showmatch
set laststatus=2

" for taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map tl :Tlist<cr> 

" for winmanager
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:bufExplorerMaxHeight=50
let g:persistentBehaviour=0
nmap wm :WMToggle<cr>

" for cscope used in quickfix
:set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

" <F5> for quick refresh when the project changed
nmap <F5> :!ctags -R .<CR>
		\ :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR> 
		\ :!cscope -b -i cscope.files -f cscope.out<CR> 
		\ :cs reset<CR>


" for quickfix window changing
" :cn for next, :cp for previous
nmap <F6> :cn<cr> 
nmap <F7> :cp<cr>


" for a.vim to change between .c with .h
nnoremap <silent> <F12> :A<CR>

"for grep.vim 
nnoremap <silent> <F3> :Grep<CR>

"for auto-complement
filetype plugin indent on
set completeopt=longest,menu
"	auto-close the preserve window after leaving insert-mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
noremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
"上下左右键的行为
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

""""""""""""""""""""""""""""""
" BufExplorer
" """"""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.

" for vim-flake(for python code review)
" 禁止PyFlakes使用QuickFix，这样在按下<F7>时会调用flake8，而有对于代码编辑时的错误仍能得到有效的提示
let g:pyflakes_use_quickfix = 0

"  " 如有需要，可设置忽略部分错误
let g:flake8_ignore="E501"
