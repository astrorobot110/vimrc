scriptencoding utf-8

function! s:packer() abort
	if exists('g:drWorkPath')
		packadd dailyreading
	endif

	if exists('g:qcExe') && exists('g:qcPath') && exists('$QIITA_ACCESS_TOKEN')
		packadd qiitactl
	endif

	if exists('g:hymnalaPath')
		packadd hymnala
	endif

	if exists('g:browser')
		packadd toBrowser
	endif
endfunction

command! Packer call s:packer()
