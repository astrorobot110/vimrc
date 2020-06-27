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

" gboardローダー
if g:device ==? 'lenovo'
	Gboard large
elseif g:device ==? 'xperia'
	Gboard small
endif

" gboard用
if g:isDroid || g:isTermux
	noremap <u <<
	noremap >i >>
endif
