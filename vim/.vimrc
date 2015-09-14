" some statement
"	vim-scripts web page: http://vim-scripts.org/vim/scripts.html
"	vim.org/scripts: http://www.vim.org/scripts/index.php


" for vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" BundleInstall
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
Bundle 'Shougo/neocomplete.vim'
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
set tabstop=3
set shiftwidth=3
set expandtab
set sts=3
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
   nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
   nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
   set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" <F5> for quick refresh when the project changed
nmap <F5> :!ctags -R .<CR>
		\ :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
		\ :!cscope -b -i cscope.files -f cscope.out<CR>
		\ :cs reset<CR>


" for quickfix window changing
" :cn for next, :cp for previous
nmap <F6> :cp<cr>
nmap <F7> :cn<cr>



" for a.vim to change between .c with .h
nnoremap <silent> <F12> :A<CR>

"for grep.vim
nnoremap <silent> <F3> :Grep<CR>
:let Grep_Default_Filelist = '*.c *.cpp *.asm'
:let Grep_Default_Options = '-ir'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""Newly created file title""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"自动插入文件头·
"
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
"
""定义函数SetTitle，自动插入文件头

func SetTitle()
    "if file type is shell script
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name:".expand("%"))
        call append(line(".")+1, "\# Author:hey")
        call append(line(".")+2, "\# mail: hey@vmware..com")
        call append(line(".")+3,"\# Created Time:".strftime("%c"))
        call append(line(".")+4,"\#########################################################################")
        call append(line(".")+5,"\#!/bin/bash")
        call append(line(".")+6,"")

    else
        call setline(1, "\*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: hey")
        call append(line(".")+2, "    > Mail: hey@vmware.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif

    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif

    autocmd BufNewFile * normal G

endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""V
""""print the trailing whitespace""""
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
""""delete the trailing whitespace before saving the text automatically.""""
autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplete#close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
"" For cursor moving in insert mode(Not recommended)
""inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
""inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
""inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
""inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"" Or set this.
""let g:neocomplete#enable_cursor_hold_i = 1
"" Or set this.
""let g:neocomplete#enable_insert_char_pre = 1
"
"" AutoComplPop like behavior.
""let g:neocomplete#enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif
""let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
""let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
""let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"" For perlomni.vim setting.
"" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
