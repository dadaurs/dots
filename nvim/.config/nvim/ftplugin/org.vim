
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
set conceallevel=2
hi! Normal guibg=NONE ctermbg=NONE
hi! EndOfBuffer cterm=NONE gui=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#2e303e
"hi! clear Conceal
hi CursorLine   cterm=NONE ctermbg=0 ctermfg=NONE guibg=#2E333F guifg=NONE gui=NONE
set nu
setlocal spell
set spelllang=fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
