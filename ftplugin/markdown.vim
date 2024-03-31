" Open with Previm
nnoremap <buffer> gx :<C-u>PrevimOpen<CR>

if isdirectory(g:private.daily)
	let b:daily = {}
	let dir = substitute(g:private.daily, '\\', '/', 'g')->escape('/')
	let buf = substitute(expand('%:p'), '\\', '/', 'g')
	if match(buf, dir) >= 0
		lcd %:h
		let b:daily.files = glob('*.md', 0, 1)
		let b:daily.current = index(b:daily.files, expand('%:t'))
		if b:daily.current < 0
			let b:daily.current = len(b:daily.files)
			call add(b:daily.files, expand('%:t'))
		endif
	endif

	nnoremap <buffer> [d :call dailyMover#main(-1)<CR>
	nnoremap <buffer> ]d :call dailyMover#main(1)<CR>
endif

