" some statement
"	vim-scripts web page: http://vim-scripts.org/vim/scripts.html
"	vim.org/scripts: http://www.vim.org/scripts/index.php


" for vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" BundleInstall
set nocompatible " be iMproved
set backspace=indent,eol,start
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" " required!
Bundle 'gmarik/vundle'

" " vim-scripts repos
Bundle 'a.vim'
Bundle 'taglist.vim'
"Bundle 'winmanager'
Bundle 'grep.vim'
Bundle 'bufexplorer.zip'
" for auto comment
Bundle 'Shougo/neocomplete.vim'
Bundle 'scrooloose/nerdcommenter'
" for python code syntax inspect
"Bundle 'nvie/vim-flake8'
"Bundle 'davidhalter/jedi-vim'
Bundle 'vim-scripts/python.vim'
Bundle 'tomasr/molokai'
Bundle 'nanotech/jellybeans.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'yssl/QFEnter'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'c.vim'
Bundle 'junegunn/vim-easy-align'
Bundle 'tpope/vim-fugitive.git'
Bundle 'airblade/vim-gitgutter'
Bundle 'skywind3000/asyncrun.vim'
"Bundle 'prabirshrestha/async.vim'
"Bundle 'prabirshrestha/asyncomplete.vim'
"Bundle 'python.vim--Vasiliev'
" Bundle 'vim-scripts/SuperTab'
"Bundle 'vim-scripts/OmniCppComplete'
"Bundle 'vim-scripts/AutoComplPop'
"Bundle 'Valloric/YouCompleteMe'


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
nmap <F5> :!ctags -R  .<CR>
		\ :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
		\ :!cscope  -b -i cscope.files -f cscope.out<CR>
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
syntax enable
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
   set t_Co=256
endif
try
   colorscheme jellybeans
catch
endtry
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
set shiftwidth=3
set tabstop=3
"configure indent for python
autocmd FileType python setlocal et sta sw=3 sts=3

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
let g:airline_theme="jellybeans"
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for auto-complement
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
      endfunction
      " <TAB>: completion.
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      " <C-h>, <BS>: close popup and delete backword char.
      inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
      inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
      " Close popup by <Space>.
      "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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
