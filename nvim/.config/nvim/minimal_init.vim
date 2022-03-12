"set guioptions-=m
"set guioptions-=T
"set guioptions-=r
"set guioptions-=L
"set guifont=Iosevka\ Nerd\ Font:h18
"dont litter ~
"set wildmenu
"set noswapfile 
"filetype plugin indent on
"syntax on
"syntax enable
"set nonumber
"set nocompatible
"set mouse=a
"set splitbelow
""set termguicolors
"set autoindent
""let $NVIM_ENABLE_TRUE_COLOR=1
""let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
let $NVIM_ENABLE_CURSOR_SHAPE=1
"set t_co=256
set encoding=utf-8
set cursorline
set nobackup
set fdm=marker
set noshowmode
set nolist wrap linebreak breakat&vim
set ignorecase
set smartcase
set splitright
set hlsearch
set incsearch
set ignorecase
set smartcase
set ruler
set hidden
set complete+=i
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'SirVer/ultisnips' 
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsEditSplit="vertical"
let g:vimtex_quickfix_mode=0
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let g:vimtex_view_general_viewer='zathura'
let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_quickfix_enabled=0
nmap <silent> <C-t> :VimtexTocToggle<CR>
"let g:livepreview_previewer = 'zathura'
"let g:vimtex_compiler_method = "pdflatex"
call plug#end()
