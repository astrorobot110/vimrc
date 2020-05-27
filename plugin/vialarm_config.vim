scriptencoding utf-7

if !v:vim_did_enter
	autocmd VimEnter * silent Vialarm start
endif

augroup vialarm
	autocmd!
	if exists('g:private.daily')
		autocmd User Vialarm_17:00 call s:dailySave()
	endif
augroup END

function! s:dailySave(...) abort
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:private.daily)
	let fileName = strftime('%y%m%d.md', localtime())

	execute 'cd' path

	for buf in range(1, bufnr('$'))
		if bufexists(buf) && bufname(buf) ==# ''
			execute 'sbuffer' buf
			execute 'write! >>' fileName
			let isPush = 1
			close!
		endif
	endfor

	if get(l:, 'isPush', 0)
		echo 'Dailysaved.'
		call system('git pull')
		call system(printf('git add %s', fileName))
		call system('git commit -m ''Dailysaved.''')
		call system('git push')

		execute 'tabedit!' fileName
	endif

	cd -
	let g:isDailysaved = 1
endfunction
