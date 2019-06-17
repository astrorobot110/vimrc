scriptencoding utf-8

function! s:vimtutor(...) abort
	let $TUTORCOPY = $VIMFILES.'/.tutor'
	if a:0 > 0
		let $xx = a:1
	endif
	new
	source $VIMRUNTIME/tutor/tutor.vim
	new $TUTORCOPY
	on
endfunction

command! -nargs=? Tutorial call s:vimtutor(<f-args>)
