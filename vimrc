" text editor
syntax on
set ruler
set number
set hlsearch
set backspace=indent,eol,start 

" two spaces for tab
set tabstop=2
set shiftwidth=2
set expandtab

" except C and Python 
autocmd FileType python 
  \ setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType c
  \ setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

" load plugins
execute pathogen#infect()
filetype plugin indent on
colorscheme brookstream

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" nerdtree
autocmd VimEnter * NERDTree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let g:NERDTreeDirArrows=0
let NERDTreeShowHidden=1
nmap <LocalLeader>nn :NERDTreeToggle<cr>
nmap <LocalLeader>nm :NERDTreeToggle<cr>

" close vim if the only window left open is a NERDTree
autocmd bufenter * 
  \ if (winnr("$") == 1 && exists("b:NERDTreeType") 
    \ && b:NERDTreeType == "primary") | q | endif

" tlist
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
nmap <LocalLeader>tt :Tlist<cr>
