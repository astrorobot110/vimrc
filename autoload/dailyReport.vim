scriptencoding utf-8

let s:dateFormat = '%y%m%d'

function s:delta(date, delta, format = '%Y/%m/%d') abort
python3 << EOF
import datetime
import vim

aDate = vim.eval("a:date")
aDelta = int(vim.eval("a:delta"))
aFormat = vim.eval("a:format")

date = datetime.datetime.strptime(aDate, aFormat)
delta = datetime.timedelta(days=aDelta)
dateTo = date + delta

vim.command("let dateTo =" + dateTo.strftime(aFormat))
EOF

	return dateTo
endfunction

function! dailyReport#moveRelative(delta) abort
	let b:currentMemo = index(g:dailyReportLs, expand('%:t'))

	try
		let openTo = g:dailyReportLs[b:currentMemo+a:delta]
	catch /^Vim\%((\a\+)\)\=:E684:/
		let openTo = s:delta(split(g:dailyReportLs[-1], '\.')[0], 1, s:dateFormat)..'.md'
	endtry

	call dailyReport#open(openTo)
endfunction

function! dailyReport#moveAbsolute(delta) abort
	let openTo = s:delta(expand('%:t:r'), a:delta, s:dateFormat)..'.md'

	call dailyReport#open(openTo)
endfunction

function! dailyReport#open(file) abort
	try
		call printf('edit %s', a:file)->execute()
	catch /^Vim\%((\a\+)\)\=:E37:/
		call printf('split %s', a:file)->execute()
	endtry
endfunction

function! dailyReport#makeURI(file) abort
	let path = split(a:file, ':\?[\/\\]')
	call remove(path, 0, match(path, 'obsidian')-1)
	let uri = printf('obsidian://vault/%s', join(path, '/'))
	if &shell =~ '\(powershell\|pwsh\)'
		call printf("Start-Process '%s'", uri)->system()
	else
		echom printf("URI: %s", uri)
	endif
endfunction

function! dailyReport#formatter( first = a:firstline, last = a:lastline ) range abort
	let olist = 1
	let prevAddress = ''
	let formatText = [ '# 午前', '' ]
	for currentLine in getline(a:first, a:last)
		try
			let [ address, category ] = split(currentLine, '\t')
			if address != prevAddress
				let addressUrl = printf('https://www.google.co.jp/maps/search/?api=1&query=%s', address)
				call add(formatText, printf('%d. [ ] [%s](%s)', olist, address, addressUrl))
				call printf('!start %s', addressUrl)->execute('silent')
			else
				call add(formatText, printf('%d. %s)', olist, address))
			endif

			call add(formatText, printf('  - %s', category))

			let olist += 1
			let prevAddress = address
		catch /E688/
			call extend(formatText, [ '', '# 午後', '' ])
		endtry
	endfor

	call extend(formatText, [ '', '# 写真' ])

	call printf('%d,%ddelete', a:first, a:last)->execute('silent')

	call append(0, formatText)
	call append(getbufinfo(bufnr())[0].linecount, [ '', '# リンク', '', printf('<%s>', @*), '', '```qrcode', @*, '```' ])
endfunction
