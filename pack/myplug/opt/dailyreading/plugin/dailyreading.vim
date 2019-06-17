scriptencoding utf-8

let s:workPath = g:drWorkPath

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

command! -bang OpenReading call s:open('<bang>')
command! -nargs=? -bang ExportReading call s:dailyReading('<bang>', <q-args>)
