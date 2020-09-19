" =============================================================================
" Filename: autoload/lightline/colorscheme/wal.vim
" Author: Dylan Araps
" License: MIT License
" Last Change: 2017/10/28 12:21:04.
" =============================================================================

let s:black = [ g:color0, 0 ]
let s:gray = [ g:color8, 8 ]
let s:white = [ g:color7, 7 ]
let s:darkblue = [ g:color4, 4 ]
let s:cyan = [ g:color6, 6 ]
let s:green = [ g:color2, 2 ]
let s:orange = [ g:color5, 5 ]
let s:purple = [ g:color1, 1 ]
let s:red = [ g:color1, 1 ]
let s:yellow = [ g:color3, 3 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:purple ], [ s:black, s:darkblue ] ]
let s:p.normal.right = [ [ s:black, s:purple ], [ s:black, s:orange ] ]
let s:p.inactive.right = [ [ s:black, s:gray ], [ s:black, s:gray ] ]
let s:p.inactive.left =  [ [ s:black, s:gray ], [ s:black, s:gray ] ]
let s:p.insert.left = [ [ s:black, s:green ], [ s:cyan, s:gray ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:cyan, s:gray ] ]
let s:p.visual.left = [ [ s:black, s:orange ], [ s:cyan, s:gray ] ]
let s:p.normal.middle = [ [ s:black, s:darkblue ] ]
let s:p.inactive.middle = [ [ s:white, s:gray ] ]
let s:p.tabline.left = [ [ s:darkblue, s:gray ] ]
let s:p.tabline.tabsel = [ [ s:cyan, s:black ] ]
let s:p.tabline.middle = [ [ s:darkblue, s:gray ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let g:lightline#colorscheme#wal#palette = lightline#colorscheme#flatten(s:p)
