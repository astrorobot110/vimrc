scriptencoding utf-8

function! toMap#main() abort
	let line = getline('.')->split(' ')
	let line[-1] = printf('[%s](https://www.google.co.jp/maps/search/?api=1&query=%s)', line[-1], line[-1])
	call setline('.', join(line, ' '))
endfunction
