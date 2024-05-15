scriptencoding utf-8

function! toMap#main(first = a:firstline, last = a:lastline) abort range
	for l in range(a:first, a:last)
		let line = getline(l)->split(' ')
		let line[-1] = printf('[%s](https://www.google.co.jp/maps/search/?api=1&query=%s)', line[-1], line[-1])
		call setline(l, join(line, ' '))
	endfor
endfunction
