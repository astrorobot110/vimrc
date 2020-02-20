scriptencoding utf-8

packadd vialarm
Vialarm! start

augroup vialarm
	autocmd!
	if exists('g:dailySaveDir')
		autocmd User Vialarm_17:00 call s:dailySave()
	endif
augroup END

function! s:dailySave(...) abort
	let currentBuf = bufnr()
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:dailySaveDir)
	let fileName = strftime('%y%m%d.md', localtime())

	execute 'cd' path

	for buf in range(1, bufnr('$'))
		if buflisted(buf) && bufname(bufnr(buf)) ==# ''
			execute 'buffer!' buf
			execute 'write! >>' fileName
		endif
	endfor

	call system(printf('git add %s', fileName))
	call system('git commit -m ''Dailysaved.''')
	call system('git push')

	execute 'buffer!' currentBuf
	cd -

	echo 'Dailysaved.'
endfunction
