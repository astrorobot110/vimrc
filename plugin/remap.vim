scriptencoding utf-8

" 甘えるな、hjklを使え
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <nop>

inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Right> <nop>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" DroidVimはカーソルなし無理！
if g:isDroid
	set mouse=a
	noremap <leftmouse> <nop>
	noremap! <leftmouse> <nop>
	noremap <up> <up>
	noremap <down> <down>
endif

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" :term のバインドひどくね？
if exists(':tmap') == 2
	tnoremap <ESC> <C-w>N
endif

" args辿る用
noremap <Leader>PP :first<CR>
noremap <Leader>pp :prev<CR>
noremap <Leader>nn :next<CR>
noremap <Leader>NN :last<CR>

" アンドゥ便利だと言ってもどうしてもshiftが押せない
nnoremap g= g+

" キーマップgxがうるさいのでなんとかしたい (メモ)
" テスト用url http://google.com
" nmap <silent> gx <Plug>NetrwBrowseX

" markdownをよく使うようになったので
noremap <Leader>md :<C-u>setlocal ft=markdown<CR>

" 移動関係
noremap <Leader>ee :<C-u>e %:h<CR>
noremap <Leader>e. :<C-u>e .<CR>

" エクスプローラーを開く用
if has('win32')
	noremap <silent> <Leader>xx :<C-u>silent !explorer "%:h"<CR>
endif
