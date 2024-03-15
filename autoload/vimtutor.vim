scriptencoding utf-8

function! vimtutor#main(...) abort
	let lang = exists('a:1') ? a:1 : v:lang
	let enc = exists('a:2') ? a:2 : &fileencoding

	let filename = filter([ 'tutor', lang, enc ], {idx, val -> val != '' })->join('.')

	while !filereadable(printf('%s/tutor/%s', $VIMRUNTIME, filename))
		if enc == ''
			let lang = ''
			let enc = exists('a:2') ? a:2 : &fileencoding
		elseif enc == 'utf-8'
			let enc = ''
		else
			let enc = 'utf-8'
		endif

		let filename = filter([ 'tutor', lang, enc ], {idx, val -> val != '' })->join('.')
	endwhile

	call execute('split $VIMRUNTIME/tutor/'..filename)
	set noreadonly
	file tutor

	return
endfunction
