"===========================================================================================================
"Defaults:
"===========================================================================================================
"---{{{
set wildmenu
set noswapfile 
filetype plugin indent on
syntax on
syntax enable
set nonumber
set nocompatible
set mouse=a
set splitbelow
"set termguicolors
set autoindent
let $NVIM_ENABLE_TRUE_COLOR=1
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
let $NVIM_ENABLE_CURSOR_SHAPE=1
set t_co=256
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
"Other:
"---{{{2
let g:utl_cfg_hdl_mt_generic = 'silent !zathura "%p" & disown'
let g:utl_cfg_hdl_scm_http_system = "silent !surf '%u#%f' &"
autocmd FileType help wincmd L
"---}}}
"---}}}
"===========================================================================================================
let mapleader=" "
"Maps:
"---{{{2

map k gk
map j gj
map ' gt
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-h> <C-w>h
map <up> <nop>
map <down> <nop>
map <right> <nop>
map <left> <nop>
"---}}}
"Nnoremaps:
"---{{{2
nnoremap <silent> <Tab> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap ; :
nnoremap <C-e> :tabnew<CR>
nnoremap <silent><Esc> :noh<cr>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>e :call CallTerm()<cr>
nnoremap <c-x>k :q<cr>
nnoremap <leader>e :vs<cr>:term<cr>a
"---}}}
"Tnoremaps:
"---{{{2
tnoremap <c-n> <c-\><c-n>
tnoremap <c-x>k <c-\><c-n>:q<cr>
noremap <c-h> <c-\><c-n><c-w><c-h>
noremap <c-k> <c-\><c-n><c-w><c-k>
noremap <c-j> <c-\><c-n><c-w><c-j>
noremap <c-l> <c-\><c-n><c-w><c-l>
"---}}}
"Inoremaps:
"---{{{2

inoremap <C-s> <Esc>:w<cr>a
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>
inoremap <left> <nop>

inoremap jk <Esc>
inoremap kj <Esc>
inoremap kk <Esc>
inoremap jj <Esc>

"---}}}
"Vnoremaps:
"---{{{2
vnoremap < <gv
vnoremap > >gv
vnoremap <c-c> "*y
vnoremap <c-v> "*p
vnoremap K :move '<-2<CR>gv-gv
vnoremap J :move '>+1<CR>gv-gv
"---}}}
"Cabbrevs:
"---{{{2
cabbrev smi !doas make install
cabbrev cn tabedit ~/.config/nvim/init.vim 
cabbrev xd !xrdb %
cabbrev cmx !chmod +x %
cabbrev ue call UE()
cabbrev xre !xmonad --recompile >/dev/null 2>&1 && xmonad --restart
cabbrev me !make build
function! UE()
	write
	execute "UltiSnipsEdit()"
endfunction
"---}}}
"Autocmds:
"---{{{2
autocmd Filetype python nnoremap <buffer> <C-c> :!python %<cr>
autocmd Filetype urls nnoremap  yr :r!python /home/david/any/src/newsboat-url-generator/newsboat-urls-generator.py -u $(xsel --clipboard --output)
"---}}}
"---}}}
"===========================================================================================================
"Plugins:
"===========================================================================================================
"---{{{1
call plug#begin('~/.vim/plugged')
"Latex:
"---{{{2
Plug 'PietroPate/vim-tex-conceal', { 'for': ['latex', 'tex'] }
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': ['latex', 'tex'] }
let g:vimtex_quickfix_mode=0
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let g:vimtex_view_general_viewer='zathura'
let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_quickfix_enabled=0
nmap <silent> <C-t> :VimtexTocToggle<CR>
"let g:livepreview_previewer = 'zathura'
"let g:vimtex_compiler_method = "pdflatex"

"---}}}
"Utilities:
"---{{{2

"Plug 'nvim-treesitter/nvim-treesitter'

Plug 'scrooloose/nerdcommenter' 
"Plug 'vim-scripts/utl.vim'
"Plug 'scrooloose/nerdtree'
	"nnoremap <silent> <leader>n :NERDTreeToggle<cr>
	"let NERDTreeQuitOnOpen=1
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'mattn/calendar-vim'
"Plug 'vim-scripts/SearchComplete'
"Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

"Plug 'chrisbra/unicode.vim'
Plug 'liuchengxu/vista.vim', { 'for': ['tex', 'latex', 'c', 'cpp'] }
"nnoremap <silent> <leader>G :Goyo<cr>
"Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"let g:which_key_use_floating_win = 0
"Vimwiki calendar
"{{{ ---
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
autocmd FileType vimwiki map <silent> c :call ToggleCalendar()
"---}}}
"---}}}
"FZF:
"---{{{2
source $HOME/.config/nvim/confzf.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    let g:fzf_layout = { 'down': '~40%' }
nnoremap <leader>H :History ~<CR>
command! -bang -nargs=* Find call fzf#vim#grep('rg --column  --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nnoremap <silent> <leader>F :FZF ~<CR>
nnoremap <silent> <leader>R :Find<CR>
nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <C-s> :Lines<CR>
nnoremap <silent> <leader>; :History:<CR>
nnoremap <silent> <leader>b :w<CR>:Buffers<CR>
nnoremap <silent> <leader>r :Rg<CR>
"---}}}
"
"Lightline:
"---{{{2
Plug 'itchyny/lightline.vim'
"Plug 'sainnhe/lightline_foobar.vim'
""Plug 'vim-airline/vim-airline'
""Plug 'vim-airline/vim-airline-themes'
""let g:airline_powerline_fonts = 1
""let g:airline_theme='deus'
let g:lightline = {
      \ 'colorscheme': 'wal',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
	"\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
"---}}}
"Snippets:
"---{{{2
Plug 'SirVer/ultisnips' 
"Plug 'SirVer/ultisnips' , { 'for': ['latex' ,'tex']}
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsEditSplit="vertical"
"---}}}
"Syntax:
"---{{{2
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
let g:vim_markdown_math = 1
set conceallevel=2
Plug 'baskerville/vim-sxhkdrc', { 'for': ['sxhkdrc']}
"---}}}
"Git:
"---{{{2
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
"---}}}
"Other:
"---{{{2
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'codota/tabnine-vim'

nnoremap <c-x><c-f> <plug>(fzf-complete-path)

"Plug 'christoomey/vim-tmux-navigator'
Plug 'dylanaraps/wal.vim'
"Plug 'dense-analysis/ale'
Plug 'lilydjwg/colorizer'
"Plug 'metakirby5/codi.vim'
  "let g:codi#interpreters = {
                   "\ 'python': {
                       "\ 'bin': 'python',
                       "\ 'prompt': '^\(>>>\|\.\.\.\) ',
                       "\ },
                   "\ }
"nnoremap <leader>L :ALEToggle<CR>
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
"Plug 'mhinz/vim-startify'
"---}}}
"===========================================================================================================
"Colors:
"===========================================================================================================
"---{{{
Plug 'sainnhe/sonokai'

Plug 'mhartington/oceanic-next'
Plug 'franbach/miramare'
Plug 'sainnhe/edge'
"---}}}
"---
call plug#end()
"---}}}
"===========================================================================================================
"Satusline:
"===========================================================================================================


"set laststatus=0

"set statusline=
set statusline+=%#CocListBgMagenta#
"set statusline+=\ \ 
"set statusline+=\ %#PmenuSel#
"set statusline+=\ %F
"set statusline+=\ %{&modified?'[+]':''}
"set statusline+=\ %r
"set statusline+=%=
"set statusline+=%#Wildmenu#\ 
"set statusline+=\ %l/%L
"set statusline+=\ %p%%
"set statusline+=\ [%n]

"===========================================================================================================
"Colorscheme:
"===========================================================================================================
"---{{{1
set t_Co=25
let g:quantum_black=1
if  $COLOR_SCHEME == "light"
    set background=light
    colorscheme gruvbox
else
    set background=dark
    "colorscheme OceanicNext
    "colorscheme horizon
    "colorscheme equinusocio_material
    "colorscheme base16-eighties
    "colorscheme oceanic_material
    colorscheme wal
endif
"let g:quantum_italics=1
hi! Normal guibg=NONE ctermbg=NONE
hi! EndOfBuffer cterm=NONE gui=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#2e303e
"hi! clear Conceal
"hi CursorLine   cterm=NONE ctermbg=0  ctermfg=NONE guibg=#DDDDDD guifg=NONE gui=NONE
hi MatchParen   cterm=NONE ctermbg=12 ctermfg=NONE guibg=#DDDDDD guifg=NONE gui=NONE
hi CursorLine   cterm=NONE ctermbg=0 ctermfg=NONE guibg=#2E333F guifg=NONE gui=NONE
"set laststatus=0
"---}}}

