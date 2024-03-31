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

function! dailyMover#main(delta) abort
	try
		let openTo = b:daily.files[b:daily.current+a:delta]
	catch /^Vim\%((\a\+)\)\=:E684:/
		let openTo = s:delta(split(b:daily.files[-1], '\.')[0], 1, '%y%m%d')..'.md'
		call add(b:daily.files, openTo)
	endtry

	try
		call printf('edit %s', openTo)->execute()
	catch /^Vim\%((\a\+)\)\=:E37:/
		call printf('split %s', openTo)->execute()
	endtry
endfunction
