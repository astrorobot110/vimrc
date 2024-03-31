" Open with Previm
nnoremap <buffer> gx :<C-u>PrevimOpen<CR>

if isdirectory(g:private.daily)
	let b:daily = {}
	let dir = substitute(g:private.daily, '\\', '/', 'g')->escape('/')
	let buf = substitute(expand('%:p'), '\\', '/', 'g')
	if match(buf, dir) >= 0
		lcd %:h
		let b:daily.files = glob('*.md', 0, 1)->sort()
		if index(b:daily.files, expand('%:t')) < 0
			call add(b:daily.files, expand('%:t'))->sort()
		endif
		let b:daily.current = index(b:daily.files, expand('%:t'))
	endif

	nnoremap <buffer> <silent> [d :<C-u>call dailyMover#main(v:count == 0 ? -1 : -v:count)<CR>
	nnoremap <buffer> <silent> ]d :<C-u>call dailyMover#main(v:count == 0 ? 1 : v:count)<CR>
endif

