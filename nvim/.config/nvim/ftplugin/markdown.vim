"map <silent> <leader>t :VimtexCompile<CR>
inoremap : è
inoremap ; é
inoremap '' à
inoremap < ;
inoremap > :
inoremap =o ô
inoremap =e ê
inoremap `u û
inoremap =a â
inoremap =u ù
inoremap =c ç

inoremap << <
inoremap >> >
nnoremap <silent> <space>t :w<cr>:! pandoc %:p -o %:r.pdf  <cr><cr>
nnoremap <silent> <space>pv :!zathura %:r.pdf & disown<cr><cr>
"call vimtex#syntax#init()
"syn match texMathSymbol '\\pathspace' contained conceal cchar=Ω
"syn match texMathSymbol '\\mathbb{R}' contained conceal cchar=ℝ
"syn match texMathSymbol '\\mathbb{S}' contained conceal cchar=𝕊
"syn match texMathSymbol '\\mathbb{T}' contained conceal cchar=𝕋
"syn match texMathSymbol '\\mathbb{U}' contained conceal cchar=𝕌
