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
if has('patch-8.0.1108')
	tnoremap <ESC> <C-w>n
endif

" バッファ辿る用
noremap <Leader>HH :br<CR>
noremap <Leader>hh :bp<CR>
noremap <Leader>ll :bn<CR>
noremap <Leader>LL :bl<CR>

" args辿る用
noremap <Leader>PP :first<CR>
noremap <Leader>pp :prev<CR>
noremap <Leader>nn :next<CR>
noremap <Leader>NN :last<CR>

"アンドゥ便利だと言ってもどうしてもshiftが押せない
nnoremap g= g+

" markdownをよく使うようになったので
noremap <Leader>md :<C-u>set ft=markdown<CR>

" 移動関係
noremap <Leader>ee :<C-u>e %:h<CR>
noremap <Leader>EE :<C-u>e! %:h<CR>

" 関数リストよく見るので
nnoremap <Leader>ff :<C-u>vert bo help function-list<CR>
nnoremap <Leader>FF :<C-u>bel help function-list<CR>

" エクスプローラーを開く用
if has('win32')
	noremap <silent> <Leader>xx :<C-u>silent !explorer "%:h"<CR>
endif
