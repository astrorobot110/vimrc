scriptencoding utf-8

function! bibleUrl#getUrl(...) abort
	let index = a:0 > 0 ? a:1 : input('index: ')
	let bibleVer = a:0 > 1 ? a:2 : ''

	let isVerse = v:false
	let chk = 0
	while chk < 3
		if index[chk] =~# '\a'
			let isVerse = v:true
			let chk = 3
		endif
		let chk += 1
	endwhile

	if isVerse
		return bibleUrl#bible(index, bibleVer)
	else
		return bibleUrl#higoto(index)
	endif
endfunction

function! bibleUrl#bible(verse, bibleVer) abort
	let verse = join([a:verse[0:2]] + split(substitute(a:verse[3:-1], '^\.', '', ''), ':'), '.')
	let bibleVer = a:bibleVer !=# '' ? a:bibleVer : 1819
	return printf('https://www.bible.com/ja/bible/%d/%S', bibleVer, toupper(verse))
endfunction

function! bibleUrl#higoto(rawDate) abort
	let year = strftime('%Y')
	let date = split(a:rawDate, '-')

	if len(date) == 1
		let decDate = str2nr(date[0], 10)
		let date = [ decDate/10000, decDate%10000/100, decDate%100 ]
	endif
	if len(date) == 2
		call insert(date, year, 0)
	endif
	if date[0] < 100
		let date[0] += year - date[0]
	endif

	return 'https://higo.to/spip.php?date='.printf('%04d-%02d-%02d', date[0], date[1], date[2])
endfunction

function! bibleUrl#local(isBang, index,...) abort
	if exists('g:bibleText')
		let bibleVer = a:0 > 0 && exists('g:bibleVer['.a:1.']') ? a:1 : 81
		let currentBuffer = bufwinid(bufname('.'))
		let verse = [ a:index[0:2] ] + split(a:index[3:], '[\.:]')
		let arg = join([ g:bibleText[bibleVer], verse[0] ], '/')
		let arg .= len(verse) > 1 ? printf('/%03d.txt', verse[1]) : ''
		let line = len(verse) > 2 ? printf('+%d', split(verse[2], '[\.:]')[0]) : '+1'
		let cmd = len(verse) > 1 && a:isBang ==# '' ? 'bo pedit' : 'bo split'
		execute cmd line arg
	else
		call bibleUrl#main('!', a:index)
	endif
endfunction

function! bibleUrl#main(isBang, ...) abort
	let index = a:1
	let bibleVer = a:0 > 1 ? a:2 : ''

	let @b = bibleUrl#getUrl(index, bibleVer)

	if a:isBang ==# '!'
		try
			execute 'OpenBrowser' @b
		catch /E492/
			execute 'belowright' '1new' '+setlocal\ buftype=nofile|put\ b'
		endtry
	else
		execute 'normal "bPw'
	endif
endfunction
