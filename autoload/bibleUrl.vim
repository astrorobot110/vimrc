scriptencoding utf-8

let s:browser = exists('g:browser') ? shellescape(g:browser) : ''

if &shell =~? '\v(powershell|pwsh)'
	let s:browser = '&'.s:browser
endif

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
	return printf('https://bible.com/ja/bible/%d/%S', bibleVer, toupper(verse))
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

function! bibleUrl#local(index)
	let currentBuffer = bufwinid(bufname('.'))
	let verse = [ a:index[0:2] ] + split(a:index[3:], '[\.:]')
	let line = substitute(verse[2], '\d+\zs.\*','','')
	execute 'bo pedit' printf('+%s %s/%s/%03d.txt', line, g:bibleText.path, tolower(verse[0]), verse[1])
endfunction

function! bibleUrl#put(...) abort
	if a:0 == 0
		let index = input('verse: ')
		let bibleVer = input('version: ')
	else
		let index = a:1
		let bibleVer = a:0 > 1 ? a:2 : ''
	endif

	if mode() ==# 'i'
		return bibleUrl#getUrl(index, bibleVer)
	else
		let @r = bibleUrl#getUrl(index, bibleVer)
		execute 'normal "rPw'
	endif
endfunction

function! bibleUrl#read(isBang,index,...) abort
	let bibleVer = a:0 > 0 ? a:1 : ''

	if a:isBang ==# '' && exists('g:bibleText')
		call bibleUrl#local(a:index)
	else
		let cmd = join([s:browser, bibleUrl#getUrl(a:index, bibleVer)])
		echo cmd
		call system(cmd)
	endif
endfunction

imap <expr> <Plug>(bibleUrl#put) bibleUrl#put()
