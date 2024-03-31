scriptencoding utf-8

function! toMap#main() abort
	let currentLine = getcurpos()[1]
	let line = getline('.')->split(' ')
"	let url = 'https://www.google.co.jp/maps/place/'..s:urlEncode(line[-1])
	let line[-1] = printf('[%s](https://www.google.co.jp/maps/search/?api=1&query=%s)', line[-1], line[-1])
	call setline(currentLine, join(line, ' '))

	let cursorTo = getline('.')->strridx('()')
	call cursor(currentLine, cursorTo+1)
endfunction
