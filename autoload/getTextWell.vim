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
		let pos = { 'start': getpos("'<"), 'end': getpos("'>") }
		let pos.end[2] = min([pos.end[2], len(getline(pos.end[1]))])

		let opts = {}
		let opts.type = s:getModeWell()

		let region = getregion(pos.start, pos.end, opts)
		call map(region, { _, val -> trim(val) })
		let region = join(region, "\n")
	else
		let region = getline('.')->trim()
	endif

	return region
endfunction

