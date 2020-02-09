scriptencoding utf-8

packadd vialarm

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User Vialarm_11:05 call s:dailySave('$INTERNAL_STORAGE/Documents/git/memo')
		autocmd User Vialarm_17:00 call s:dailySave('$INTERNAL_STORAGE/Documents/git/memo')
	endif
augroup END

function! s:dailySave(path) abort
	try
		let currentBuf = bufnr()
		let fileName = strftime('dailysave/%y%m%d.md', localtime())
		execute 'cd' a:path
		for buf in range(1, bufnr('$'))
			try
				if bufname(buf) ==# ''
					silent execute 'buffer!' buf
					silent execute 'write! >>' fileName
				endif
			catch /E86/
				continue
			endtry
		endfor

		if getftype(fileName) !=# ''
			silent !git add *
			silent !git commit -m "Dailysaved."
			silent !git push
		endif

		cd -
		execute 'buffer!' currentBuf
	catch /E216/
		echoerr printf('Failed in ''cd %s''', a:path)
	endtry
endfunction
