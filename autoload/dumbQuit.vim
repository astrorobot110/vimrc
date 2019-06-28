scriptencoding utf-8

function! dumbQuit#main() abort
	if winnr('$')*tabpagenr('$') <= 1 && histget('cmd',-1) ==# 'q'
		sbuffer | echo 'To quit, type ''q!'', ''quit'', etc...'
	endif
endfunction
