scriptencoding utf-8

function! s:init() abort
	if !exists("s:initFontSize")
		if &guifont =~? ':h\d\+'
			let s:initFontSize = substitute(&guifont, '.*:h\(\d\+\).*', '\1', '')
		else
			let s:initFontSize = substitute(&guifont, '.\{-}\(\d\+\)$', '\1', '')
		endif
	endif
endfunction

function! zoooom#setZoom(delta) abort
	call s:init()
	if &guifont =~? ':h'
		let delimiter = ':'
		let param = split(&guifont, ':')

		for index in range(0, len(param)-1)
			if param[index][0] == 'h'
				let param[index] = printf('h%d', str2nr(param[index][1:]) + a:delta)
			endif
		endfor
	else
		let delimiter = ' '
		let param = [ join(split(&guifont, ' ')[0:-2], ' '), split(&guifont, ' ')[-1] ]
		let param[1] = param[1] + a:delta
	endif

	let &guifont = join(param, delimiter)
	return join(param, delimiter)
endfunction

function! zoooom#init() abort
	if &guifont =~? ':h'
		let &guifont = substitute(&guifont, ':h\zs\d\+', s:initFontSize, '')
	else
		let &guifont = substitute(&guifont, '\d\+$', s:initFontSize, '')
	endif
endfunction

function! zoooom#showInit() abort
	echo s:initFontSize
	return s:initFontSize
endfunction
