scriptencoding utf-8

function! deLyric#main() range abort
	let subList = [
		\ [ '<\/\?div.\{-}>', '' ],
		\ [ '　', ' ' ],
		\ [ '<br.\{-}>', '\r' ]
	\ ]

	for [ sub, rep ] in subList
		call printf('%d,%dsubstitute/%s/%s/g', a:firstline, a:lastline, sub, rep)->execute()
	endfor

	return
endfunction

