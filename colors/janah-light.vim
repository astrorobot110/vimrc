" vim: et sw=2 sts=2

" Plugin:      https://github.com/mhinz/vim-janah
" Description: A 256 colors colorscheme for Vim.
" Maintainer:  Marco Hinz <http://github.com/mhinz>

highlight clear

if exists('syntax_on')
  syntax reset
endif

highlight Normal guifg=#252525 ctermfg=234 guibg=#d9d9d9 gui=NONE cterm=NONE

" Misc {{{1

highlight Comment guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Constant guifg=#207878 ctermfg=131 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Directory guifg=#782800 ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight EndOfBuffer guifg=#d9d9d9 ctermfg=252 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Identifier guifg=#782800 ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight MatchParen guifg=#ff207f ctermfg=86 guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight NonText guifg=#ff00af ctermfg=48 guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight Number guifg=#207878 ctermfg=131 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight PreProc guifg=#503000 ctermfg=24 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Special guifg=#502020 ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight SpecialKey guifg=#c5c5c5 ctermfg=250 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Statement guifg=#487820 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight String guifg=#204878 ctermfg=137 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Title guifg=#287800 ctermfg=91 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Todo guifg=#503000 ctermfg=24 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Type guifg=#207848 ctermfg=132 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight VertSplit guifg=#c5c5c5 ctermfg=250 guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE
highlight WildMenu guifg=#ff207f ctermfg=86 guibg=#c5c5c5 ctermbg=250 gui=bold cterm=bold

" Cursor lines {{{1

highlight CursorColumn ctermfg=NONE guibg=#cfcfcf ctermbg=251 gui=NONE cterm=NONE
highlight CursorLine ctermfg=NONE guibg=#cfcfcf ctermbg=251 gui=NONE cterm=NONE

" Tabline {{{1

highlight TabLine guifg=#7f7f7f ctermfg=243 guibg=#cfcfcf ctermbg=251 gui=NONE cterm=NONE
highlight TabLineFill guifg=#505020 ctermfg=60 guibg=#cfcfcf ctermbg=251 gui=NONE cterm=NONE
highlight TabLineSel guifg=#1b1b1b ctermfg=233 guibg=#cfcfcf ctermbg=251 gui=bold cterm=bold

" Statusline {{{1

highlight StatusLine guifg=#1b1b1b ctermfg=233 guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE
highlight StatusLineNC guifg=#7f7f7f ctermfg=243 guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE

" Number column {{{1

highlight CursorLineNr guifg=#787878 ctermfg=145 guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE
highlight LineNr guifg=#787878 ctermfg=145 guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE

" Color column {{{1

highlight ColorColumn ctermfg=NONE guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE

" Diff & Signs {{{1

highlight SignColumn ctermfg=NONE guibg=#c5c5c5 ctermbg=250 gui=NONE cterm=NONE

highlight DiffAdd guifg=#28a000 ctermfg=128 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiffDelete guifg=#a02020 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiffChange guifg=#a0a000 ctermfg=20 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiffText guifg=#a00000 ctermfg=44 guibg=#ffa0a0 ctermbg=195 gui=bold cterm=bold

" Folds {{{1

highlight FoldColumn ctermfg=145 ctermbg=250 cterm=NONE guifg=#787878 guibg=#c5c5c5 gui=NONE
highlight Folded ctermfg=145 ctermbg=250 cterm=NONE guifg=#787878 guibg=#c5c5c5 gui=NONE

" Search {{{1

highlight IncSearch guifg=#3f3f3f ctermfg=8 guibg=#005fff ctermbg=220 gui=NONE cterm=NONE
highlight Search guifg=#3f3f3f ctermfg=8 guibg=#ff207f ctermbg=86 gui=NONE cterm=NONE

" Messages {{{1

highlight Error guifg=#111111 ctermfg=232 guibg=#ff2020 ctermbg=87 gui=NONE cterm=NONE
highlight ErrorMsg guifg=#111111 ctermfg=232 guibg=#ff2020 ctermbg=87 gui=NONE cterm=NONE
highlight ModeMsg guifg=#287800 ctermfg=91 guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight MoreMsg guifg=#3f3f3f ctermfg=8 guibg=#207fff ctermbg=221 gui=NONE cterm=NONE
highlight WarningMsg guifg=#3f3f3f ctermfg=8 guibg=#207fff ctermbg=221 gui=NONE cterm=NONE

" Visual {{{1

highlight Visual guifg=#3f3f3f ctermfg=8 guibg=#78d7ff ctermbg=223 gui=NONE cterm=NONE
highlight VisualNOS guifg=#3f3f3f ctermfg=8 guibg=#7878a0 ctermbg=187 gui=NONE cterm=NONE

" Pmenu {{{1

highlight Pmenu guifg=#1b1b1b ctermfg=233 guibg=#d9d9d9 ctermbg=252 gui=NONE cterm=NONE
highlight PmenuSbar ctermfg=NONE guibg=#bbbbbb ctermbg=249 gui=NONE cterm=NONE
highlight PmenuSel guifg=#a02020 ctermfg=80 guibg=#bbbbbb ctermbg=249 gui=bold cterm=bold
highlight PmenuThumb ctermfg=NONE guibg=#a02020 ctermbg=80 gui=NONE cterm=NONE

" Spell {{{1
highlight SpellBad guifg=#3f3f3f ctermfg=8 guibg=#a02020 ctermbg=80 gui=NONE cterm=NONE
highlight SpellCap guifg=#3f3f3f ctermfg=8 guibg=#207fff ctermbg=221 gui=NONE cterm=NONE
highlight SpellLocal guifg=#3f3f3f ctermfg=8 guibg=#d750ff ctermbg=156 gui=NONE cterm=NONE
highlight SpellRare guifg=#3f3f3f ctermfg=8 guibg=#78ffd7 ctermbg=218 gui=NONE cterm=NONE

" Quickfix {{{1
highlight qfLineNr    ctermfg=249 ctermbg=NONE cterm=NONE guifg=#bbbbbb guibg=NONE gui=NONE
highlight qfSeparator ctermfg=244 ctermbg=NONE cterm=NONE guifg=#898989 guibg=NONE gui=NONE

" Plugin: vim-easymotion {{{1
highlight EasyMotionTarget guifg=#a0a000 ctermfg=20 guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight EasyMotionTarget2First guifg=#ff207f ctermfg=86 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight EasyMotionTarget2Second guifg=#a0a000 ctermfg=20 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Plugin: vim-rfc {{{1
highlight RFCType guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight RFCID guifg=#a05000 ctermfg=32 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight RFCTitle guifg=#111111 ctermfg=232 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight RFCDelim guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Plugin: vim-signify {{{1
highlight SignifySignAdd guifg=#28a000 ctermfg=128 guibg=#c5c5c5 ctermbg=250 gui=bold cterm=bold
highlight SignifySignDelete guifg=#a02020 ctermfg=80 guibg=#c5c5c5 ctermbg=250 gui=bold cterm=bold
highlight SignifySignChange guifg=#a0a000 ctermfg=20 guibg=#c5c5c5 ctermbg=250 gui=bold cterm=bold

" Plugin: vim-startify {{{1
highlight StartifyBracket guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifyFile guifg=#111111 ctermfg=232 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifyFooter guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifyHeader guifg=#207820 ctermfg=133 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifyNumber guifg=#a05000 ctermfg=32 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifyPath guifg=#757575 ctermfg=242 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifySection guifg=#502020 ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifySelect guifg=#0080a0 ctermfg=166 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifySlash guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight StartifySpecial guifg=#a7a7a7 ctermfg=247 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Neovim {{{1

highlight TermCursor ctermfg=NONE guibg=#ff00af ctermbg=48 gui=NONE cterm=NONE
highlight TermCursorNC ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" HTML {{{1

highlight link htmlTagN htmlTagName


let g:colors_name = 'janah-light'

