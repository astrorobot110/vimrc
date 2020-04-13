scriptencoding utf-8

if &columns <= 80
	augroup vimhelp
		autocmd!
		autocmd FileType help setlocal nowrap
	augroup END
endif
