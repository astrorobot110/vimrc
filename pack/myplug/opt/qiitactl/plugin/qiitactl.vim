scriptencoding utf-8

" アクセストークンの環境変数は別記
let s:qcPath = g:qcPath
let s:qcExe = g:qcExe

function! s:qcFetch() abort
	exec 'cd' s:qcPath
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
	cd -
endfunction

function! s:qcGenerate(filename) abort
	exec 'cd' s:qcPath
	let qcCmd = system(s:qcExe.' generate file '.a:filename)
	exec 'new '.join([s:qcPath, qcCmd], '/')
	exec '%s/\v%(tags:)@<=\s+\[\]/\r- Vim/g'
	call cursor(line('$'), 1)
	write
	cd -
endfunction

function! s:qcCreate() abort
	write
	let args = "'".expand('%:p')."'"
	exec 'cd' s:qcPath
	let qcCmd = system(s:qcExe.' create post --tweet '.args)
	echo qcCmd.'...done.'
	edit!
	cd -
endfunction

function! s:qcUpdate() abort
	write
	let args = "'".expand('%:p')."'"
	exec 'cd' s:qcPath
	let qcCmd = system(s:qcExe.' update post '.args)
	echo qcCmd.'...done.'
	edit!
	cd -
endfunction

command! QiitaFetch call s:qcFetch()
command! -nargs=1 QiitaGenerate call s:qcGenerate(<f-args>)
command! QiitaCreate call s:qcCreate()
command! QiitaUpdate call s:qcUpdate()

" リマップ用
command! QiitaFiles new +setlocal\ bt=nofile|put=escape(glob(s:qcPath.'/**/*.md'),'\ ')
