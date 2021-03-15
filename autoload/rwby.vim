scriptencoding utf-8

function! s:chordText() abort
	let self = {}

	let self.lyric = []
	let self.chord = []

	function! self.getChord(line) abort
		let self.lyric = []
		let self.chord = []

		let element = split(a:line, '[\[\]]')

		if a:line[0] !=# '['
			call add(self.chord, '')
			let dest = 'lyric'
		else
			let dest = 'chord'
		endif

		for e in element
			call add(self[dest], e)
			let dest = dest ==# 'lyric' ? 'chord' : 'lyric'
		endfor

		while len(self.lyric) < len(self.chord)
			call add(self.lyric, '&#9:')
		endwhile
		
		return self
	endfunction

	function! self.toRuby() abort
		let source = ''

		for n in range(len(self.lyric))
			if self.chord[n] ==# ''
				let source .= self.lyric[n]
			else
				let source .= printf(
						\ '<ruby><rb>%s</rb><rp>[</rp><rt>%s</rt><rp>]</rp></ruby>',
						\ self.lyric[n],
						\ self.chord[n])
			endif
		endfor

		return source
	endfunction

	return self
endfunction

function! rwby#main() range abort
	for n in range(a:firstline, a:lastline)
		if len(getline(n)) > 0
			let current = s:chordText()
			call current.getChord(getline(n))
			let replace = current.toRuby()..'<br>'

			call setline(n, replace)
		endif
	endfor
endfunction
