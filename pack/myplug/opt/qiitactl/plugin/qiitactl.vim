scriptencoding utf-8

" アクセストークンの環境変数は別記
let g:qcDir = '~/Documents/qiitactl'
let g:qcExe = 'qiitactl'

function! s:qcFetch() abort
	exec 'cd' g:qcDir
	let qcChk = getline(2)
	if qcChk =~# '\v^id: \x+$'
		echo 'Fetching single post.'
		let isFetchSingle = 1
		let qcCmd = system(g:qcExe.' fetch post --id='.qcChk[-20:])
	else
		echo 'Fetching entire posts.'
		let isFetchSingle = 0
		let qcCmd = system(g:qcExe.' fetch posts')
	endif
	echo qcCmd.'...done.'
	if isFetchSingle == 1
		edit!
	endif
	cd -
endfunction

function! s:qcGenerate(...) abort
	let args = "'".join(a:000)."'"
	exec 'cd' g:qcDir
	let qcCmd = system(g:qcExe.' generate file '.args)
	exec 'new '.join([g:qcDir, qcCmd], '/')
	exec '%s/\v%(tags:)@<=\s+\[\]/\r- Vim/g'
	call cursor(line('$'), 1)
	write
	cd -
endfunction

function! s:qcCreate() abort
	write
	let args = "'".expand('%:p')."'"
	exec 'cd' g:qcDir
	let qcCmd = system(g:qcExe.' create post --tweet '.args)
	echo qcCmd.'...done.'
	edit!
	cd -
endfunction

function! s:qcUpdate() abort
	write
	let args = "'".expand('%:p')."'"
	exec 'cd' g:qcDir
	let qcCmd = system(g:qcExe.' update post '.args)
	echo qcCmd.'...done.'
	edit!
	cd -
endfunction

command! QiitaFetch call s:qcFetch()
command! -nargs=+ QiitaGenerate call s:qcGenerate(<f-args>)
command! QiitaCreate call s:qcCreate()
command! QiitaUpdate call s:qcUpdate()

" リマップ用
command! QiitaFiles new +setlocal\ bt=nofile|put=escape(glob(g:qcDir.'/**/*.md'),'\ ')
