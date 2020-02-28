scriptencoding utf-8

if g:isDroid || g:isTermux
	augroup vimhelp
		autocmd!
		autocmd FileType help setlocal nowrap
	augroup END
endif
