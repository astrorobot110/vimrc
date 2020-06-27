scriptencoding utf-8

augroup reportFiletype
	autocmd!
	autocmd BufRead,BufNewFile */kim/*.md setlocal filetype=report
	autocmd BufRead,BufNewFile */memo/xperia/*.md setlocal filetype=report
	autocmd BufNewFile */kim/*.md call setline(1, report#templates())
augroup END
