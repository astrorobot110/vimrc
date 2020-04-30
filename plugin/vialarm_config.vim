scriptencoding utf-8

if !v:vim_did_enter
	autocmd VimEnter * silent Vialarm start
endif

augroup vialarm
	autocmd!
	if exists('g:dailySaveDir')
		autocmd User Vialarm_17:00 call s:dailySave()
	endif
augroup END

function! s:dailySave(...) abort
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:dailySaveDir)
	let fileName = strftime('%y%m%d.md', localtime())

	execute 'cd' path

	for buf in range(1, bufnr('$'))
		if bufexists(buf) && bufname(buf) ==# ''
			execute 'buffer!' buf
			execute 'write! >>' fileName
			let isPush = 1
		endif
	endfor

	if get(l:, 'isPush', 0)
		echo 'Dailysaved.'
		call system('git pull')
		call system(printf('git add %s', fileName))
		call system('git commit -m ''Dailysaved.''')
		call system('git push')

		execute 'edit!' fileName
	endif

	cd -
endfunction
