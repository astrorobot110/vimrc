scriptencoding utf-8

function! s:daily() abort
	let script = expand('$HOME/.vim/ftplugin/daily.vim')
	if filereadable(script)
		call execute('source '..script)
	endif
endfunction

augroup customFt_daily
	autocmd!
	autocmd BufNewFile,BufRead */obsidian/daily/*.md,*/obsidian/daily/*/*.md
			\ call s:daily()
augroup END

