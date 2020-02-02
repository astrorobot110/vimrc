scriptencoding utf-8

packadd vialarm

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User vialarm_17:00 call s:dailySave('$INTERNAL_STORAGE/Documents/git/memo')
	endif
	autocmd User vialarm_20:00 call s:nenaiko(20)
	autocmd User vialarm_22:00 call s:nenaiko(22)
augroup END

function! s:dailySave(path) abort
	let currentBuf = bufnr()
	let fileName = strftime('dailysave/%y%m%d.md', localtime())
	try
		execute 'cd' a:path
		for buf in range(1, bufnr('$'))
			try
				if bufname(buf) ==# ''
					execute 'buffer!' buf
					execute 'write! >>' fileName
				endif
			catch /E86/
			endtry
		endfor

		if getftype(fileName) !=# ''
			echo system('git add '.expand('%'))
			echo system('git commit -m ''dailysaved.''')
			echo system('git push')
		endif

		cd -
		execute 'buffer!' currentBuf
	catch /E216/
		echoerr printf('Failed in ''cd %s''', a:path)
	endtry
endfunction

function! s:nenaiko(hour) abort
	if a:hour == 22
		echo 'ねないこだれだ'
	else
		echo 'はやくねなさい'
	endif
endfunction
