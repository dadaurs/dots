" =============================================================================
" Filename: autoload/lightline/colorscheme/wal.vim
" Original Author: Dylan Araps
" Forked By: bloodflame
" License: MIT License
" =============================================================================

let s:black             = [ '', 232 ]
let s:grey              = [ '', 0 ]
let s:red               = [ '', 1 ]
let s:green             = [ '', 2 ]
let s:yellow            = [ '', 3 ]
let s:blue              = [ '', 4 ]
let s:magenta           = [ '', 5 ]
let s:cyan              = [ '', 6 ]
let s:white             = [ '', 7 ]
let s:brightgrey        = [ '', 8 ]
let s:brightred         = [ '', 9 ]
let s:brightgreen       = [ '', 10 ]
let s:brightyellow      = [ '', 11 ]
let s:brightblue        = [ '', 12 ]
let s:brightmagenta     = [ '', 13 ]
let s:brightcyan        = [ '', 14 ]
let s:brightwhite       = [ '', 15 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:black, s:cyan ],        [ s:brightcyan, s:grey ] ]
let s:p.normal.middle   = [ [ s:cyan, s:black ] ]
let s:p.normal.right    = [ [ s:black, s:cyan ],        [ s:brightcyan, s:grey ] ]
let s:p.normal.error    = [ [ s:red, s:black ] ]
let s:p.normal.warning  = [ [ s:yellow, s:black ] ]

let s:p.inactive.left   = [ [ s:brightgrey, s:black ],  [ s:brightgrey, s:black ] ]
let s:p.inactive.middle = [ [ s:brightgrey, s:black ] ]
let s:p.inactive.right  = [ [ s:brightgrey, s:black ],  [ s:brightgrey, s:black ] ]

let s:p.insert.left     = [ [ s:black, s:green ],       [ s:brightgreen, s:grey ] ]
let s:p.insert.middle   = [ [ s:green, s:black ] ]
let s:p.insert.right    = [ [ s:black, s:green ],       [ s:brightgreen, s:grey ] ]

let s:p.replace.left    = [ [ s:black, s:red ],         [ s:brightred, s:grey ] ]
let s:p.replace.middle  = [ [ s:red, s:black ] ]
let s:p.replace.right   = [ [ s:black, s:red ],         [ s:brightred, s:grey ] ]

let s:p.visual.left     = [ [ s:black, s:magenta ],     [ s:brightmagenta, s:grey ] ]
let s:p.visual.middle   = [ [ s:magenta, s:black ] ]
let s:p.visual.right    = [ [ s:black, s:magenta ],     [ s:brightmagenta, s:grey ] ]

let s:p.tabline.left    = [ [ s:brightgrey, s:grey ] ]
let s:p.tabline.middle  = [ [ s:blue, s:black ] ]
let s:p.tabline.right   = [ [ s:black, s:black ],       [ s:brightwhite, s:grey ] ]
let s:p.tabline.tabsel  = [ [ s:black, s:blue ] ]

let g:lightline#colorscheme#wal#palette = lightline#colorscheme#flatten(s:p)
