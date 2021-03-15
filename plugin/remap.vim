scriptencoding utf-8

" 甘えるな、hjklを使え (
if !(g:isDroid || g:isTermux)
	noremap <Left> <Nop>
	noremap <Down> <Nop>
	noremap <Up> <Nop>
	noremap <Right> <nop>
endif

inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Right> <nop>

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" どうしてもg+が押せなかったので
nnoremap g= g+

" 空行入れ
nnoremap <silent> "<Space> "="\n"<CR>
nnoremap <silent> "<S-Space> "="\n"<CR>

" gboard用
if g:isDroid || g:isTermux
	noremap <u <<
	noremap >i >>
endif

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
