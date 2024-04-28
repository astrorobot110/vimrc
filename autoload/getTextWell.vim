scriptencoding utf-8

function! s:getModeWell() abort
	let mode = mode()[0]
	if mode !~ '[vV]'
		let mode = visualmode()
	endif

	return mode
endfunction

function! getTextWell#main(range) range abort
	if a:range != 0
		let startPos = getpos("'<")
		let endPos = getpos("'>")
		let endPos[2] = min([endPos[2], len(getline(endPos[1]))])
		let opts = {}
		let opts.type = s:getModeWell()
		let region = getregion(startPos, endPos, opts)->join(nr2char(10))
	else
		let region = getline('.')
	endif

	return region
endfunction

