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
nnoremap "<space> "="\n"<CR>

" gboard用
if g:isDroid || g:isTermux
	nnoremap <C-^>uu <<
	nnoremap <C-^>ii >>
	nnoremap <C-^>t [
	nnoremap <C-^>y ]
	nnoremap <C-^>o {
	nnoremap <C-^>p }
endif
