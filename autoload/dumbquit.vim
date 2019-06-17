scriptencoding utf-8

if has('patch-8.0.1595')
	" :qでvimを終了させないための処理
	function! dumbquit#quitChk() abort
		if winnr('$')*tabpagenr('$') <= 1 && histget('cmd',-1) ==# 'q'
			sbuffer | echo 'To quit, type ''q!'', ''quit'', etc...'
		endif
	endfunction

	augroup dumbQuit
		autocmd!
		if v:servername =~? 'VIM\?\d*$' || !has('clientserver')
			au ExitPre * call dumbquit#quitChk()
		endif
	augroup END
endif
