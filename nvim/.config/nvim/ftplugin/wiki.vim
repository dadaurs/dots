function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction

nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>
call matchadd('Conceal', '<-\&<', 10, -1, {'conceal':'←'})
call matchadd('Conceal', '<\zs-', 10, -1, {'conceal':' '})
call matchadd('Conceal', 'eee', 10, -1, {'conceal':'e'})
