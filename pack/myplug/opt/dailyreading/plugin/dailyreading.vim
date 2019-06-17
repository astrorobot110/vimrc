scriptencoding utf-8

let s:workPath = '~\cloud\gdrive\christ\twitter\'
let s:browser = '&'.shellescape(g:browser)

let g:isDrReadable = isdirectory(expand(s:workPath))

if g:isDrReadable

	let s:aftPath = s:workPath.'reading'

	function! s:dailyReading(isBang, path) abort
		let target = a:path !=? '' ? a:path : s:aftPath
		if expand('%:p:h') ==? glob(s:aftPath) && a:isBang !=# '!'
			write
			new | set filetype=markdown
			execute 'file' s:workPath.expand('#:t:r').'.md'
			call s:convert(expand('#:p'), 1)
			write!
		else
			new | set filetype=markdown
			execute 'file' s:workPath.'reading.md'
			call s:concat(target)
			write!
		endif
	endfunction

	function! s:convert(draftFile, headLevel) abort
		let fileName = split(split(a:draftFile, '[\\\/]')[-1], '\.')[0]

		let title = a:headLevel == 1 ? '# 週日ミサまとめ - ' : repeat('#', a:headLevel).' '
		if fileName =~# '\v^[0-9]{6}$'
			let title .= printf("'%d年 %d月%d日", str2nr(fileName[0:1]), str2nr(fileName[2:3]), (fileName[4:5]))
		else
			let title .= fileName
		endif

		call setline(line('$'), title)

		let draft = readfile(a:draftFile)
		for cd in draft
			call append(line('$'), ['', substitute(cd, '\(https\?:\/\/[0-9A-Za-z_\/:%#\$&?()\~\.=+\-,]\+\)', '<\1>', 'g')])
		endfor
	endfunction

	function! s:concat(targetDraft) abort
		let readings = split(glob(a:targetDraft.'\*.txt'),'\n')

		call setline(line('$'), '# 週日ミサまとめ')

		for cr in readings
			call append(line('$'), repeat([''], 2))
			call s:convert(cr, 2)
		endfor
	endfunction

	function! s:open(isBang) abort
		let weekday = strftime('%w', localtime())
		let banged = a:isBang ==# '!' ? (13-weekday)*24*60*60 : (6-weekday)*24*60*60
		let schedule = split(strftime('%y,%m,%d,%w', localtime()+banged), ',')
		let fileName = printf('\%02d%02d%02d.txt', schedule[0], schedule[1], schedule[2])
		let cmd = getbufinfo(bufname(''))[0]['changed'] ? 'split' : 'edit'
		execute cmd s:aftPath.fileName
	endfunction

endif

function! s:getUrl(...) abort
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
		return s:bible(index, bibleVer)
	else
		return s:higoto(index)
	endif
endfunction

function! s:url(isBang, ...) abort
	if a:0 != 0
		let index = a:1
		let bibleVer = a:0 > 1 ? a:2 : ''
		let @r = s:getUrl(index, bibleVer)

		if a:isBang ==# '' && g:isDrReadable
			call system(join([s:browser, @r], ' '))
		else
			execute 'normal "rpl'
		endif
	else
		execute '%s/\v(my\.|www\.)bible\.com/bible.com/ge'
	endif
endfunction

function! s:bible(verse, bibleVer) abort
	let verse = join([a:verse[0:2]] + split(substitute(a:verse[3:-1], '^\.', '', ''), ':'), '.')
	let bibleVer = a:bibleVer !=# '' ? a:bibleVer : 1819
	return printf('https://bible.com/ja/bible/%d/%S', bibleVer, toupper(verse))
endfunction

function! s:higoto(rawDate) abort
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

if g:isDrReadable
	command! -nargs=* -bang -complete=dir Reading call s:dailyReading('<bang>', <q-args>)
	command! -bang Ropen call s:open('<bang>')
endif

command! -nargs=* -bang Rurl call s:url('<bang>', <f-args>)
inoremap <expr> <Plug>(dr_getUrl) s:getUrl()
