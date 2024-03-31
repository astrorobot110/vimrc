scriptencoding utf-8

setlocal fileformat=unix

" vimscript to unix fileformat
augroup vimscriptFileFormat
	autocmd!
	autocmd BufWritePre *.vim set fileformat=unix
augroup END

