scriptencoding utf-8

let s:cpo = &cpoptions
set cpoptions&vim

function! deltaLine#main() abort
	set relativenumber!
	augroup deltaLine
		autocmd!
		autocmd CursorMoved * ++once set relativenumber!
	augroup END
endfunction

let &cpoptions = s:cpo
