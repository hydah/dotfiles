set number
set nocompatible
filetype on
set history=1000

syntax enable
syntax on

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
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
nmap <F5> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR> 
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
