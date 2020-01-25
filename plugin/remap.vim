scriptencoding utf-8

" 甘えるな、hjklを使え (
if !g:isDroid
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

" Gboard用
if exists(':Gboard')
	if $VIMDEVICE =~? '_mobile$'
		Gboard small
	else
		Gboard large
	endif
endif
