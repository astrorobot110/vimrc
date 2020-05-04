scriptencoding utf-8

augroup reportFiletype
	autocmd!
	autocmd BufRead,BufNewFile */kim/report/*.md setlocal filetype=report
	autocmd BufRead,BufNewFile */memo/xperia/*.md setlocal filetype=report
	autocmd BufNewFile */kim/report/*.md call setline(1, report#templates())
augroup END
