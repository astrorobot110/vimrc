scriptencoding utf-8

" in Normal mode {{{

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" どうしてもg+が押せなかったので
nnoremap g= g+

" Insertモードが絡むremap
nnoremap <Leader>, i,<Esc>
nnoremap <Leader>. i.<Esc>
nnoremap <Leader>? i?<Esc>
nnoremap <Leader>! i!<Esc>
nnoremap <Leader><Space> i <Esc>
nnoremap <Leader><CR> i<CR><Esc>

noremap <Leader>i :<C-u>set iminsert=2<CR>i
noremap <Leader>I :<C-u>set iminsert=2<CR>I
noremap <Leader>a :<C-u>set iminsert=2<CR>a
noremap <Leader>A :<C-u>set iminsert=2<CR>A
noremap <Leader>o :<C-u>set iminsert=2<CR>o
noremap <Leader>O :<C-u>set iminsert=2<CR>O
noremap <Leader>R :<C-u>set iminsert=2<CR>R
noremap <Leader>c :<C-u>set iminsert=2<CR>c
noremap <Leader>C :<C-u>set iminsert=2<CR>C
noremap <Leader>s :<C-u>set iminsert=2<CR>s
noremap <Leader>S :<C-u>set iminsert=2<CR>S

" 設定群への移動専用
nnoremap <Leader>v :<C-u>e v

" bang実行
nnoremap <expr> <Leader>: substitute( @:, '^\(\S\+\)', ':\1!', 'e')

" 旧Zmenu

" Move directory to current buffer
nnoremap Zd :<C-u>lcd %:h<CR>
nnoremap ZD :<C-u>cd %:h<CR>

" Quick help to function-list
nnoremap Zh :<C-u>vert bo help function-list<CR>

" PlugInstall
nnoremap Zp :<C-u>PlugUpdate<CR>
nnoremap ZP :<C-u>PlugInstall<CR>

" Load current vimscript
nnoremap Zs :<C-u>source %<CR>

" Execute current line as shell command
nnoremap <expr> Z! system(expand(getline('.')))

" CalcIt
nnoremap Z= :<C-u>put =eval(getline('.'))<CR>$

" Open current buffer's directory
nnoremap Z% :<C-u>edit %:h<CR>

" Open recent
nnoremap Z# :<C-u>edit #<1<CR>

" Open secret launcher
nnoremap Zb :<C-u>tabedit ~\Documents\Documents\bookmark.md<CR>

" }}}

" in Insert mode {{{

inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Right> <nop>

" IMEのキーマップ暴発対策
imap <Nul> <Nop>

" インサートモード中の^hに対応して^lで<del>させる様に
inoremap <C-l> <del>

" calcIt (コマンドモードなら<C-r>=あるので)
inoremap <expr> <C-z>= nr2char(10)..eval(getline('.'))

" }}}

" in Command mode {{{

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" }}}

" vim: set foldmethod=marker :
