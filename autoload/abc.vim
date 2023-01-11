scriptencoding utf-8

let s:scaleDict = {
		\		"C"   : { "C": "C", "D": "Dm", "E": "Em", "F": "F", "G": "G", "A": "Am", "B": "Bm7-5" },
		\		"G"   : { "G": "G", "A": "Am", "B": "Bm", "C": "C", "D": "D", "E": "Em", "F": "F#m7-5" },
		\		"D"   : { "D": "D", "E": "Em", "F": "F#m", "G": "G", "A": "A", "B": "Bm", "C": "C#m7-5" },
		\		"A"   : { "A": "A", "B": "Bm", "C": "C#m", "D": "D", "E": "E", "F": "F#m", "G": "G#m7-5" },
		\		"E"   : { "E": "E", "F": "F#m", "G": "G#m", "A": "A", "B": "B", "C": "C#m", "D": "D#m7-5" },
		\		"B"   : { "B": "B", "C": "C#m", "D": "D#m", "E": "E", "F": "F#", "G": "G#m", "A": "A#m7-5" },
		\		"F#"  : { "F": "F#", "G": "G#m", "A": "A#m", "B": "B", "C": "C#", "D": "D#m", "E": "E#m7-5" },
		\		"Gb"  : { "G": "Gb", "A": "Abm", "B": "Bbm", "C": "Cb", "D": "Db", "E": "Ebm", "F": "Fm7-5" },
		\		"Db"  : { "D": "Db", "E": "Ebm", "F": "Fm", "G": "Gb", "A": "Ab", "B": "Bbm", "C": "Cm7-5" },
		\		"Ab"  : { "A": "Ab", "B": "Bbm", "C": "Cm", "D": "Db", "E": "Eb", "F": "Fm", "G": "Gm7-5" },
		\		"Eb"  : { "E": "Eb", "F": "Fm", "G": "Gm", "A": "Ab", "B": "Bb", "C": "Cm", "D": "Dm7-5" },
		\		"Bb"  : { "B": "Bb", "C": "Cm", "D": "Dm", "E": "Eb", "F": "F", "G": "Gm", "A": "Am7-5" },
		\		"F"   : { "F": "F", "G": "Gm", "A": "Am", "B": "Bb", "C": "C", "D": "Dm", "E": "Em7-5" },
		\		"Cm"  : { "C": "Cm", "D": "Dm7-5", "E": "Eb", "F": "Fm", "G": "Gm", "A": "Ab", "B": "Bb" },
		\		"Gm"  : { "G": "Gm", "A": "Am7-5", "B": "Bb", "C": "Cm", "D": "Dm", "E": "Eb", "F": "F" },
		\		"Dm"  : { "D": "Dm", "E": "Em7-5", "F": "F", "G": "Gm", "A": "Am", "B": "Bb", "C": "C" },
		\		"Am"  : { "A": "Am", "B": "Bm7-5", "C": "C", "D": "Dm", "E": "Em", "F": "F", "G": "G" },
		\		"Em"  : { "E": "Em", "F": "F#m7-5", "G": "G", "A": "Am", "B": "Bm", "C": "C", "D": "D" },
		\		"Bm"  : { "B": "Bm", "C": "C#m7-5", "D": "D", "E": "Em", "F": "F#m", "G": "G", "A": "A" },
		\		"F#m" : { "F": "F#m", "G": "G#m7-5", "A": "A", "B": "Bm", "C": "C#m", "D": "D", "E": "E" },
		\		"C#m" : { "C": "C#m", "D": "D#m7-5", "E": "E", "F": "F#m", "G": "G#m", "A": "A", "B": "B" },
		\		"G#m" : { "G": "G#m", "A": "A#m7-5", "B": "B", "C": "C#m", "D": "D#m", "E": "E", "F": "F#" },
		\		"D#m" : { "D": "D#m", "E": "E#m7-5", "F": "F#", "G": "G#m", "A": "A#m", "B": "B", "C": "C#" },
		\		"Ebm" : { "E": "Ebm", "F": "Fm7-5", "G": "Gb", "A": "Abm", "B": "Bbm", "C": "Cb", "D": "Db" },
		\		"Bbm" : { "B": "Bbm", "C": "Cm7-5", "D": "Db", "E": "Ebm", "F": "Fm", "G": "Gb", "A": "Ab" },
		\		"Fm"  : { "F": "Fm", "G": "Gm7-5", "A": "Ab", "B": "Bbm", "C": "Cm", "D": "Db", "E": "Eb" }
		\	}

function! abc#main(scale) abort
	let targetScale = s:scaleDict[a:scale]

	let @a = "["..targetScale.A.."]"
	let @b = "["..targetScale.B.."]"
	let @c = "["..targetScale.C.."]"
	let @d = "["..targetScale.D.."]"
	let @e = "["..targetScale.E.."]"
	let @f = "["..targetScale.F.."]"
	let @g = "["..targetScale.G.."]"
endfunction
