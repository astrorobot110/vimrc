scriptencoding utf-8

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

function! dailyMover#moveRelative(delta) abort
	let b:currentMemo = index(g:dailyMoverLs, expand('%:t'))

	try
		let openTo = g:dailyMoverLs[b:currentMemo+a:delta]
	catch /^Vim\%((\a\+)\)\=:E684:/
		let openTo = s:delta(split(g:dailyMoverLs[-1], '\.')[0], 1, '%y%m%d')..'.md'
	endtry

	call dailyMover#open(openTo)
endfunction

function! dailyMover#moveAbsolute(delta) abort
	let openTo = s:delta(expand('%:t:r'), a:delta, '%y%m%d')..'.md'

	call dailyMover#open(openTo)
endfunction

function! dailyMover#open(file) abort
	try
		call printf('edit %s', a:file)->execute()
	catch /^Vim\%((\a\+)\)\=:E37:/
		call printf('split %s', a:file)->execute()
	endtry
endfunction

function! dailyMover#makeURI(file) abort
	let path = split(a:file, ':\?[\/\\]')
	call remove(path, 0, match(path, 'obsidian')-1)
	let uri = printf('obsidian://vault/%s', join(path, '/'))
	if &shell =~ '\(powershell\|pwsh\)'
		call printf("Start-Process '%s'", uri)->system()
	else
		echom printf("URI: %s", uri)
	endif
endfunction
