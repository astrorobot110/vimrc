scriptencoding utf-8

" in Normal mode {{{

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" どうしてもg+が押せなかったので
nnoremap g= g+

" ええこときいた

nnoremap gy "*y
vnoremap gy "*y

" Insertモードが絡むremap

nnoremap <Leader><Space> i <Esc>

function! ImOperation(operator) abort
	set iminsert=2
	return a:operator
endfunction

noremap <expr> <Leader>i ImOperation('i')
noremap <expr> <Leader>I ImOperation('I')
noremap <expr> <Leader>gi ImOperation('gi')
noremap <expr> <Leader>gI ImOperation('gI')
noremap <expr> <Leader>a ImOperation('a')
noremap <expr> <Leader>A ImOperation('A')
noremap <expr> <Leader>o ImOperation('o')
noremap <expr> <Leader>O ImOperation('O')
noremap <expr> <Leader>r ImOperation('r')
noremap <expr> <Leader>R ImOperation('R')
noremap <expr> <Leader>gR ImOperation('gR')
noremap <expr> <Leader>c ImOperation('c')
noremap <expr> <Leader>C ImOperation('C')
noremap <expr> <Leader>s ImOperation('s')
noremap <expr> <Leader>S ImOperation('S')
noremap <expr> <Leader>f ImOperation('f')
noremap <expr> <Leader>F ImOperation('F')
noremap <expr> <Leader>t ImOperation('t')
noremap <expr> <Leader>T ImOperation('T')

vnoremap <expr> <Leader>i ImOperation('i')
vnoremap <expr> <Leader>I ImOperation('I')
vnoremap <expr> <Leader>gi ImOperation('gi')
vnoremap <expr> <Leader>gI ImOperation('gI')
vnoremap <expr> <Leader>a ImOperation('a')
vnoremap <expr> <Leader>A ImOperation('A')
vnoremap <expr> <Leader>o ImOperation('o')
vnoremap <expr> <Leader>O ImOperation('O')
vnoremap <expr> <Leader>r ImOperation('r')
vnoremap <expr> <Leader>R ImOperation('R')
vnoremap <expr> <Leader>gR ImOperation('gR')
vnoremap <expr> <Leader>c ImOperation('c')
vnoremap <expr> <Leader>C ImOperation('C')
vnoremap <expr> <Leader>s ImOperation('s')
vnoremap <expr> <Leader>S ImOperation('S')

" ターミナルモードあるっぽい？
tnoremap <Esc><Esc> <C-w>N

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

" Zsのマップは間違えることが多すぎてアレなので
" ftpluginに移動させました。

" Execute current line as shell command
nnoremap <expr> Z! system(expand(getline('.')))

" CalcIt
nnoremap Z= :<C-u>put =eval(getline('.'))<CR>$

" Open current buffer's directory
nnoremap Z% :<C-u>edit %:h<CR>

" Open parent folder by Explorer
nnoremap Ze :<C-u>!explorer %:h<CR>

" Open recent
nnoremap Z# :<C-u>edit #<1<CR>

" Open URL by openbrowser.vim
nnoremap Zu <plug>(openbrowser-open)

" toggle background mode
nnoremap Zb :<C-u>call execute(printf('set background=%s', &background == 'dark' ? 'light' : 'dark'))<CR>

" Open today's dailymamo
nnoremap Zt :<C-u>e today=<C-]><CR>

" Previm用キーマップの`Zp`はftpluginに移動しました。

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
