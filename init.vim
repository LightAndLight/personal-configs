set nocompatible
filetype off

"vundle
"clone the vundle repo into .vim/bundle/Vundle.vim then call :PluginInstall
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'gmarik/Vundle.vim'
Plugin 'roman/golden-ratio'
Plugin 'scrooloose/syntastic'
Plugin 'jceb/vim-orgmode'
Plugin 'mattn/emmet-vim'
Plugin 'idris-hackers/idris-vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'raichoo/purescript-vim'
Plugin 'frigoeu/psc-ide-vim'
Plugin 'rust-lang/rust.vim'
":VimProcInstall
Plugin 'shougo/vimproc.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'shougo/deoplete.nvim'

call vundle#end()
filetype plugin indent on

"leader bindings
let mapleader = "\<Space>"
nnoremap <Leader>vs :vs<CR>:bnext<CR>
nnoremap <Leader>b :make!<CR>
map <Leader>n :NERDTreeToggle<CR>

"general
syntax enable
set background=light
colorscheme solarized

let g:tex_flavor='latex'

"setlocal softtabstop=4
"setlocal shiftwidth=4
set expandtab
set autoindent 

set number
set ruler
set cursorline

set backspace=indent,eol,start

inoremap jj <esc>
tnoremap <Esc> <C-\><C-n>

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"deoplete
let g:deoplete#enable_at_startup=1

"vimnotes
let g:notes_directories = ['~/notes']
let g:notes_smart_quotes = 0
let g:notes_suffix = '.note'
nnoremap <Enter> :Utl<CR>

"haskell
au FileType haskell nnoremap <Leader>c :w<CR>:GhcModSplitFunCase<CR>
au FileType haskell nnoremap <Leader>t :w<CR>:GhcModType<CR>
au FileType haskell setlocal indentexpr="" 
au FileType haskell setlocal softtabstop=2 
au FileType haskell setlocal shiftwidth=2
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

"purescript
au FileType purescript nmap <leader>c :w<CR>:PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>t :w<CR>:PSCIDEtype<CR>
au FileType purescript nmap <leader>ai :w<CR>:PSCIDEaddImportQualifications<CR>
au FileType purescript nmap <leader>i :w<CR>:PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :w<CR>:PSCIDEload<CR>
au FileType purescript setlocal indentexpr="" 
au FileType purescript setlocal softtabstop=2 
au FileType purescript setlocal shiftwidth=2
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
