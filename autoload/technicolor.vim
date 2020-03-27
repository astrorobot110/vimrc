scriptencoding utf-8

let s:Highlight = {
		\ 'isSystemColor': 0,
		\ 'isGrayScale': 0,
		\ 'cterm': {
		\ 	'isBold': 0,
		\ 	'isLine': 0,
		\ 	'isReverse': 0
		\ },
		\ 'gui': {
		\ 	'isBold': 0,
		\ 	'isLine': 0,
		\ 	'isReverse': 0
		\ },
		\ 'order': 'cterm'
		\ }

function! s:Highlight.setInRGB(ground, red, green, blue) abort
	let self.isGrayScale = a:red == a:green && a:red == a:blue &&
			\ a:red >= 95 && (a:red + 95) % 40 == 0
	let self.gui[a:ground] = map([ a:red, a:green, a:blue ], {_, val -> sort([0, val, 255])[1]})

	if self.isGrayScale
		let self.cterm[a:ground] = sort([0, self.gui[a:ground][0] - 8, 255])[1] / 10 + 232
	else
		let termColor = 0

		for value in self.gui[a:ground]
			let termColor *= 6
			if value >= 75
				let termColor += float2nr(round((value - 75) / 40.0))
			endif
		endfor

		let self.cterm[a:ground] = termColor + 16
	endif
endfunction

function! s:Highlight.setInTermColor(ground, termColor) abort
	let self.cterm[a:ground] = sort([0, a:termColor, 255])[1]
	let self.isSystemColor = self.cterm[a:ground] <= 15
	let self.isGrayScale = self.cterm[a:ground] >= 232
	let self.gui[a:ground] = []

	if self.isGrayScale
		call add(self.gui[a:ground], repeat([(self.cterm[a:ground] - 232) * 10 + 8], 3))
	elseif self.isSystemColor
		if self.cterm[a:ground] == 7
			let value = 192
		elseif self.cterm[a:ground] <= 8
			let value = 128
		else
			let value = 255
		endif

		for index in [1, 2, 4]
			call add(self.gui[a:ground], (self.cterm[a:ground] / index) % 2 * value)
		endfor
	else
		let value = [0, 95, 135, 175, 215, 255]
		for index in [36, 6, 1]
			call add(self.gui[a:ground], value[((self.cterm[a:ground] - 16) / index) % 6])
		endfor
	endif
endfunction

function! s:Highlight.getArgs() abort
	if match(getline('.'), '^hi\(ghlight\)\?!\?\ze\s\(link\)\@!') == 0
		let args = filter(split(getline('.'), '\s'), 'v:val =~# "="')
		let self.order = matchstr(args[0], '^\(cterm\|gui\)')
		for elements in args
			let state = matchlist(elements, '\(cterm\|gui\)\(fg\|bg\)\?=\(.*\)')[1:3]
			echo state
		endfor
	endif
endfunction

let g:testHighlight = deepcopy(s:Highlight)
