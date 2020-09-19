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
inoremap << <
inoremap >> >
endfunction
cabbrev <silent> fr call Francais()


"let g:tex_conceal="abdgms"
set conceallevel=2
inoremap <C-f> <Esc>: silent exec '.!bspc desktop -f 5; inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : exec '!bspc desktop -f 5;inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
cabbrev short !~/scripts/inkscape_shortcuts >/dev/null 2>&1 & disown
cabbrev shortk !~/scripts/kill_shortcuts >/dev/null 2>&1 & disown
"colorscheme wal
hi! Normal guibg=NONE ctermbg=NONE
hi! EndOfBuffer cterm=NONE gui=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#2e303e

