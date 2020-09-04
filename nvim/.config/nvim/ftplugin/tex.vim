nnoremap <silent> <leader>tt :VimtexCompile<CR>
nnoremap <silent> <leader>te :VimtexErrors<CR>

function! Francais()
inoremap : è
inoremap ; é
inoremap '' à
inoremap < ;
inoremap > :
inoremap =o ô
inoremap =e ê
inoremap 'u û
inoremap =a â
inoremap =u ù
inoremap =c ç
inoremap =i î
endfunction
cabbrev <silent> fr call Francais()


"let g:tex_conceal="abdgms"
inoremap << <
inoremap >> >
set conceallevel=2
inoremap <C-f> <Esc>: silent exec '.!bspc desktop -f 8; inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : exec '!bspc desktop -f 8;inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
cabbrev short !~/scripts/inkscape_shortcuts >/dev/null 2>&1 & disown
cabbrev shortk !~/scripts/kill_shortcuts >/dev/null 2>&1 & disown
"colorscheme wal
hi! Normal guibg=NONE ctermbg=NONE
hi! EndOfBuffer cterm=NONE gui=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#2e303e


"syn match texMathSymbol '\\sup' contained conceal contains=texSuperscripts

"hi! clear Conceal
"hi CursorLine   cterm=NONE ctermbg=0 ctermfg=NONE guibg=#2E333F guifg=NONE gui=NONE
"set nu
"setlocal spell
"set spelllang=fr
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"nnoremap L <c-g>u<Esc>[s1z=`]a<c-g>u

"let g:tex_flavor='latex'
"let g:tex_conceal='abdmg'
"let g:vimtex_view_general_viewer='zathura'
	"nmap <silent> <C-t> :VimtexTocToggle<CR>
"let g:livepreview_previewer = 'zathura'
"let g:livepreview_engine = 'pdflatex'

