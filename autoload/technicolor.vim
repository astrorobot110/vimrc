scriptencoding utf-8

let s:Highlight = {
		\ 'isSystemColor': 0,
		\ 'isGrayScale': 0,
		\ 'bg': {
		\ 	'cterm': 16,
		\ 	'gui': [ 0, 0, 0 ],
		\ },
		\ 'fg': {
		\ 	'cterm': 231,
		\ 	'gui': [ 255, 255, 255, ],
		\ },
		\ 'attr': 'NONE',
		\ }

function! s:Highlight.setInRGB(ground, red, green, blue) abort
	let self.isGrayScale = a:red == a:green && a:red == a:blue &&
			\ a:red >= 95 && a:red % 40 == 15
	let self[a:ground].gui = [ a:red, a:green, a:blue ]
			\ ->map({_, val -> max([0, min([255, val])])})

	if self.isGrayScale
		let self[a:ground].cterm = max([0, self[a:ground].gui[0] - 8]) / 10 + 232
	else
		let termColor = 0

		for value in self[a:ground].gui
			let termColor *= 6
			if value >= 75
				let termColor += round((value - 75) / 40.0)->float2nr()
			endif
		endfor

		let self[a:ground].cterm = termColor + 16
	endif
endfunction

function! s:Highlight.setInTermColor(ground, termColor) abort
	let self[a:ground].cterm = max([0, min([255, a:termColor])])
	let self.isSystemColor = self[a:ground].cterm <= 15
	let self.isGrayScale = self[a:ground].cterm >= 232

	if self.isGrayScale
		let self[a:ground].gui = repeat([(self[a:ground].cterm - 232) * 10 + 8], 3)
	elseif self.isSystemColor
		if self[a:ground].cterm < 7 || self[a:ground].cterm == 8
			let value = 128
		elseif self[a:ground].cterm == 7
			let value = 192
		else
			let value = 255
		endif

		let colorIndex = self[a:ground].cterm
		let step = [1, 2, 4]

		for index in range(3)
			let self[a:ground].gui[index] = (colorIndex / step[index]) % 2 * value
		endfor
	else
		let colorIndex = self[a:ground].cterm - 16
		let step = [36, 6, 1]
		let value = [0, 95, 135, 175, 215, 255]

		for index in range(3)
			let self[a:ground].gui[index] = value[(colorIndex / step[index]) % 6]
		endfor
	endif
endfunction
