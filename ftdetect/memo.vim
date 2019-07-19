augroup memo
	autocmd!
	execute 'au BufReadPre,BufNewFile' g:memoPath.'/*.md' 'setlocal noswapfile'
augroup END
