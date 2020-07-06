scriptencoding utf-8

augroup reportFiletype
	autocmd!
	autocmd BufRead,BufNewFile */memo/xperia/*.md setlocal filetype=report
augroup END
