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

" DroidVimはカーソルなし無理！
if g:isDroid
	set mouse=n mousemodel=extend
noremap <Left> <Nop>
noremap <Down> <Nop>
endif

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" 移動関係 (なしでいいかも)
" noremap <Leader>ee :<C-u>e %:h<CR>
" noremap <Leader>e. :<C-u>e .<CR>
