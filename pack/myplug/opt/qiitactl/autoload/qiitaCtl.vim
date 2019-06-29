scriptencoding utf-8

let s:qcPath = g:qcPath
let s:qcExe = g:qcExe

function! qiitaCtl#Fetch() abort
	execute 'lcd' s:qcPath
	let qcChk = getline(2)
	if qcChk =~# '\v^id: \x+$'
		echo 'Fetching single post.'
		let isFetchSingle = 1
		let qcCmd = system(s:qcExe.' fetch post --id='.qcChk[-20:])
	else
		echo 'Fetching entire posts.'
		let isFetchSingle = 0
		let qcCmd = system(s:qcExe.' fetch posts')
	endif
	echo qcCmd.'...done.'
	if isFetchSingle == 1
		edit!
	endif
	lcd -
endfunction

function! qiitaCtl#Generate(filename) abort
	execute 'lcd' s:qcPath
	let qcCmd = system(s:qcExe.' generate file '.a:filename)
	execute 'new '.join([s:qcPath, qcCmd], '/')
	execute '%s/\v%(tags:)@<=\s+\[\]/\r- Vim/g'
	call cursor(line('$'), 1)
	write
	lcd -
endfunction

function! qiitaCtl#Create() abort
	write
	let args = "'".expand('%:p')."'"
	execute 'lcd' s:qcPath
	let qcCmd = system(s:qcExe.' create post --tweet '.args)
	echo qcCmd.'...done.'
	edit!
	lcd -
endfunction

function! qiitaCtl#Update() abort
	write
	let args = "'".expand('%:p')."'"
	execute 'lcd' s:qcPath
	let qcCmd = system(s:qcExe.' update post '.args)
	echo qcCmd.'...done.'
	edit!
	lcd -
endfunction
