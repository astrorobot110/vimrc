scriptencoding utf-8

" Chord splitter
function! chordSplitter#main() abort
		let text = getline('.')
		let subText = substitute(text, '\v\C([A-G][#b]?%([Mdimaugs#b,0-9\+\-\(\)]+)?%(%(\/|on)[A-G][#b]?)?|\%)', '\1 ', 'ge')
		if text != subText
			let subText = '| '.substitute(subText, '\s\{2}', ' | ', 'ge').'|'
			if getline(line('.')+1) !=# '' && line('.') != line('$')
				let subText = subText.'  '
			endif
			call setline('.', subText)
		endif
endfunction
