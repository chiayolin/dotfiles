syntax on
set ruler
set number
set hlsearch
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start  

execute pathogen#infect()
filetype plugin indent on
colorscheme brookstream

autocmd VimEnter * NERDTree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1
nmap <LocalLeader>nn :NERDTreeToggle<cr>
nmap <LocalLeader>nm :NERDTreeToggle<cr>

let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
nmap <LocalLeader>tt :Tlist<cr>
