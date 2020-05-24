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
	let g:log = []
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:private.daily)
	let fileName = strftime('%y%m%d.md', localtime())

	execute 'cd' path

	for buf in range(1, bufnr('$'))
		call add(g:log, {
				\ 'bufname': bufnr(buf),
				\ 'bufexists': bufexists(buf),
				\ 'bufname': bufname(buf)
				\ })
		if bufexists(buf) && ( bufname(buf) ==# '' )
			let g:log[-1]['write'] = 1
			execute 'buffer!' buf
			execute 'write! >>' fileName
			let isPush = 1
		else
			let g:log[-1]['write'] = 0
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
