scriptencoding utf-8

augroup reportFiletype
	autocmd!
<<<<<<< HEAD
	autocmd BufRead,BufNewFile */memo/xperia/*.md setlocal filetype=report
=======
	autocmd BufRead,BufNewFile */kim/*.md setlocal filetype=report
	autocmd BufRead,BufNewFile */memo/xperia/*.md setlocal filetype=report
	autocmd BufNewFile */kim/*.md call setline(1, report#templates())
>>>>>>> a6196cd3973d80d5a90365a58326089c5b8e424b
augroup END
