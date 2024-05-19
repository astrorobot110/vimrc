scriptencoding utf-8

function! customCS#main(functionName, ...) abort
	if exists('*s:'..a:functionName)
		let CS = function('s:'..a:functionName, a:000)
		call CS()
	endif
endfunction

function! s:janah(...) abort
	" Terminal用
	highlight Normal ctermbg=235

	" ステータスライン調整
	highlight StatusLine term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermfg=216 ctermbg=16 guifg=#ffaf87 guibg=#3a3a3a

	" 分割線
	highlight VertSplit    term=reverse ctermfg=237 ctermbg=bg  guifg=#3a3a3a guibg=bg
	highlight CursorLineNr term=bold    ctermfg=110 ctermbg=240 guifg=#87afdf guibg=#585858

	" カーソルの色変更
	if has('multi_byte_ime')
		highlight CursorIM guifg=bg guibg=#87dfaf
	endif
endfunction

function!
