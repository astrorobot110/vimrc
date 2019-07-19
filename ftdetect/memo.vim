try
	if g:memoPath !=# ''
		augroup memo
			autocmd!
			execute 'au BufReadPre,BufNewFile' g:memoPath.'/*.md' 'setlocal noswapfile'
		augroup END
	endif
catch /E121/
	if !exists('g:retry')
		let g:retry = []
	endif
	call add(g:retry, expand('<sfile>:p'))
endtry
