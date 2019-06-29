scriptencoding utf-8

"   Hymnala assembler
let s:hymnalaPath = g:hymnalaPath

function! hymnala#main() abort
	exec 'cd '.s:hymnalaPath
	let bookOrder = split(matchstr(getline(1),'#\s*\zs.*'), '\s\?[\.,]\s\?')

	if len(bookOrder) > 0
		call deletebufline(bufname(''), 2, line('$'))

		let bookFile = []
		for chordFile in bookOrder
			call add(bookFile, glob('*'.chordFile.'*.txt'))
		endfor

		for chordIdx in range(len(bookFile))
			let currentChords = readfile(bookFile[chordIdx])
			let head = str2nr(bookOrder[chordIdx]) > 0 ? substitute(bookOrder[chordIdx], '^0\+', '', '').'. ' : ''
			let currentChords[0] = printf('## %s%S', head, currentChords[0])
			call setline(line('$')+1, ['']+currentChords)
		endfor
	endif
	cd -
endfunction
