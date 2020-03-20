scriptencoding utf-8

" カラースキームの個別調整

" janah
function! customCS#janah() abort
	" ステータスライン調整
	highlight StatusLine term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermfg=216 ctermbg=16 guifg=#ffaf87 guibg=#3a3a3a

	" 分割線
	highlight VertSplit term=reverse ctermfg=237 ctermbg=0 guifg=#3a3a3a guibg=bg
	highlight CursorLineNr term=bold ctermfg=110 ctermbg=240 guifg=#87afdf guibg=#585858

	" カーソルの色変更
	if has('multi_byte_ime')
		highlight CursorIM guifg=bg guibg=#87dfaf
	endif
endfunction

" wombat
function! customCS#wombat() abort
	" カーソルの色変更
	if has('multi_byte_ime')
		highlight CursorIM ctermfg=234 ctermbg=111 guifg=bg guibg=#88b8f6
	endif
endfunction
