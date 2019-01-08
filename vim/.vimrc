" some statement
"	vim-scripts web page: http://vim-scripts.org/vim/scripts.html
"	vim.org/scripts: http://www.vim.org/scripts/index.php


" for vim: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" for neovim:
"
" BundleInstall

set nocompatible " be iMproved
set backspace=indent,eol,start
" Configuration section of vundle
filetype off  " required!

call plug#begin('~/.local/share/vim/plugged')
" " vim-scripts repos
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/grep.vim'
" for python code syntax inspect
Plug 'nvie/vim-flake8'
Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/python.vim'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/c.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive.git'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'skywind3000/asyncrun.vim'
Plug 'fatih/vim-go'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-clang'
    Plug 'zchee/deoplete-go'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'zchee/deoplete-clang'
    Plug 'zchee/deoplete-go'
endif

call plug#end()



""""""""""""""""""""""""""""""
"<=== General
""""""""""""""""""""""""""""""
" Set how many lines of history VIM has to remember
set history=1000
" enable filetype plugins
filetype plugin indent on    " required!
" set to auto read when a file is changed from outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
" Reload configuration
map <leader>rr :source ~/.vimrc<CR>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" for quickfix window changing
" auto open quickfix window
autocmd FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L
nmap qi :cclose<cr>
nmap qo :cw<cr>
nmap <F6> :cp<cr>
nmap <F7> :cn<cr>
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" open in the topright
"autocmd FileType qf wincmd L
" <F5> for quick refresh when the project changed
nmap <F5> :! ctags -R  %:p:h/* <CR>
		\ :! find %:p:h  -iname '*.c' -o -iname '*.py' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
		\ :! cscope  -bqi %:p:h/cscope.files -f %:p:h/cscope.out<CR>
		\ :cs reset<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <=== VIM UserInterface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set 7 lines to the cursor
"set so = 7
" set to show line number
set number
" Turn on the WiLd menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <== color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlight
syntax on

"Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <== Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tab
set expandtab
" Be smart when using tab
set smarttab
" auto smart indent
set autoindent
set smartindent
" one tab = three spaces
let width=4
execute "set shiftwidth=".width
execute "set tabstop=".width
"configure indent for python
"autocmd FileType python setlocal et sta sw=width sts=width

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful mappings for managing tabs
map <leader>ta :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme="molokai"
let g:EchoFuncShowOnStatus = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
set showmatch
if has('statusline')
   set laststatus=2
   set statusline=%<%f\
   set statusline+=%w%h%m%r
endif
"设置切换Buffer快捷键"
nnoremap bp :bp<CR>
nnoremap bn :bn<CR>
nnoremap bd :bd<CR>
nnoremap b1 :1b<CR>
nnoremap b2 :2b<CR>
nnoremap b3 :3b<CR>
nnoremap b4 :4b<CR>
nnoremap b5 :5b<CR>
nnoremap b6 :6b<CR>
nnoremap b7 :7b<CR>
nnoremap b8 :8b<CR>
nnoremap b9 :9b<CR>
nnoremap b0 :10b<CR>
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

" for taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map tl :Tlist<cr>
" for NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
nmap <leader>nn :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" for cscope used in quickfix
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
   set cscopetag
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
   set cscopequickfix=s-,c-,d-,i-,t-,e-
   nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
   nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
   nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
" for a.vim to change between .c with .h
nnoremap <silent> <F12> :A<CR>
" for grep.vim
nnoremap <silent> <F3> :Grep<CR>
:let Grep_Default_Filelist = '*.h *.c *.cpp *.asm'
:let Grep_Default_Options = '-ir'
" for BufExplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently usedr
let g:bufExplorerFindActive=1
map <leader>o :BufExplorer<cr>

" for vim-flake(for python code review)
" 禁止PyFlakes使用QuickFix，这样在按下<F7>时会调用flake8，而有对于代码编辑时的错误仍能得到有效的提示
let g:pyflakes_use_quickfix = 0
"  " 如有需要，可设置忽略部分错误
let g:flake8_ignore="E501"

"vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

"AsyncRun
map <leader>gg :AsyncRun! git grep <cword> . <cr>
map <leader>gb :Gblame <cr>

function! CompileAndRun()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction
" Quick run via ,cr
nnoremap <leader>cr :call CompileAndRun()<CR>
augroup QuickfixStatus
        au! BufWinEnter quickfix setlocal
                \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
augroup vimrc
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

"jumps
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <Leader>j :call GotoJump()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => other mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd guibg=red ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4
"===
set showmatch
"print the trailing whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
"delete the trailing whitespace before saving the text automatically
autocmd BufWritePre * :%s/\s\+$//e

xmap ga <Plug>(EasyAlign)
let g:EchoFuncShowOnStatus = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VisualSelection(direction, extra_filter) range
   let l:saved_reg = @"
   execute "normal! vgvy"

   let l:pattern = escape(@", "\\/.*'$^~[]")
   let l:pattern = substitute(l:pattern, "\n$", "", "")

   if a:direction == 'gv'
      call CmdLine("Ag '" . l:pattern . "' " )
   elseif a:direction == 'replace'
      call CmdLine("%s" . '/'.  l:pattern . '/')
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction


set t_Co=256
colorscheme molokai



""""" auto complete
let g:deoplete#enable_at_startup = 1
"for c/c++
"let g:deoplete#sources#clang#libclang_path = "/usr/lib64/libclang.so"
"let g:deoplete#sources#clang#clang_header = "/usr/lib64/clang/5.0.1/include/"
let g:deoplete#sources#clang#libclang_path = "/data/data/com.termux/files/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/data/data/com.termux/files/usr/lib/clang/5.0.1/include/"
let g:deoplete#sources#clang#std#cpp = 'c++1z'
let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#clang#flags = [
    \ "-stdlib=libc++",
    \ ]

"""vim-go
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)
