scriptencoding utf-8

if has('patch-8.0.1595')
	" :qでvimを終了させないための処理
	function! s:quitChk() abort
		if winnr('$')*tabpagenr('$') <= 1 && histget('cmd',-1) ==# 'q'
			sbuffer | echo 'To quit, type ''q!'', ''quit'', etc...'
		endif
	endfunction

	augroup dumbQuit
		autocmd!
		if v:servername =~? 'GVIM\d*$' || !has('clientserver')
			au ExitPre * call s:quitChk()
		endif
	augroup END
endif
