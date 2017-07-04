"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/isaac/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/isaac/.config/nvim/bundle')
  call dein#begin('/home/isaac/.config/nvim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/home/isaac/.config/nvim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('YorickPeterse/happy_hacking.vim')
  call dein#add('lightandlight/gruvbox')
  call dein#add('gmarik/Vundle.vim')
  call dein#add('roman/golden-ratio')
  call dein#add('vim-syntastic/syntastic', {'rev': '3.8.0'})
  call dein#add('jceb/vim-orgmode')
  call dein#add('mattn/emmet-vim')
  call dein#add('idris-hackers/idris-vim')
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('eagletmt/ghcmod-vim')
  call dein#add('raichoo/purescript-vim')
  call dein#add('frigoeu/psc-ide-vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('shougo/vimproc.vim', {'build': 'make'})
  call dein#add('scrooloose/nerdtree')
  call dein#add('shougo/deoplete.nvim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('nbouscal/vim-stylish-haskell')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"leader bindings
let mapleader = "\<Space>"
nnoremap <Leader>vs :vs<CR>:bnext<CR>
nnoremap <Leader>b :make!<CR>
map <Leader>n :NERDTreeToggle<CR>

"general
" set termguicolors "may be needed depending on the terminal
set background=dark
syntax enable
color gruvbox

let g:tex_flavor='latex'

set expandtab
set autoindent 
set softtabstop=4
set shiftwidth=4

set number
set ruler
set cursorline

set backspace=indent,eol,start

inoremap jj <esc>
tnoremap <Esc> <C-\><C-n>

"syntastic
set statusline+=%t\ %m\ %#warningmsg#%{SyntasticStatuslineFlag()}%*%=%c,%l\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"golden-ratio
let g:loaded_golden_ratio = 0

"deoplete
let g:deoplete#enable_at_startup=1

"vimnotes
let g:notes_directories = ['~/notes']
let g:notes_smart_quotes = 0
let g:notes_suffix = '.note'
nnoremap <Enter> :Utl<CR>

"haskell
au FileType haskell nnoremap <Leader>c :w<CR>:GhcModSplitFunCase<CR>
au FileType haskell nnoremap <Leader>t :GhcModType<CR>
au FileType haskell setlocal indentexpr="" 
au FileType haskell setlocal softtabstop=2 
au FileType haskell setlocal shiftwidth=2
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

"purescript
let g:psc_ide_syntastic_mode = 1
"let g:psc_ide_log_level = 3
au FileType purescript let syntastic_always_populate_loc_list=1
au FileType purescript nmap <buffer> <leader>t :<C-U>PSCIDEtype<CR>
au FileType purescript nmap <buffer> <leader>s :<C-U>PSCIDEapplySuggestion<CR>
au FileType purescript nmap <buffer> <leader>a :<C-U>PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <buffer> <leader>i :<C-U>PSCIDEimportIdentifier<CR>
au FileType purescript nmap <buffer> <leader>r :<C-U>PSCIDEload<CR>
au FileType purescript nmap <buffer> <leader>p :<C-U>PSCIDEpursuit<CR>
au FileType purescript nmap <buffer> <leader>c :<C-U>PSCIDEcaseSplit<CR>
au FileType purescript setlocal indentexpr="" 
au FileType purescript setlocal softtabstop=2 
au FileType purescript setlocal shiftwidth=2

"git
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gm :Gmerge<CR>
nmap <leader>gp :Gpush<CR>
