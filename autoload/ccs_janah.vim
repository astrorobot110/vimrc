scriptencoding utf-8

" janah の個別調整
function! ccs_janah#main() abort
	" 液晶ごとに背景安定しねぇ
	if $VIMDEVICE !=? '_mobile$'
		highlight Normal ctermbg=234
	else
		highlight Normal ctermbg=232
	endif

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
