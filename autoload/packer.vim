scriptencoding utf-8

function! packer#main() abort
	if exists('g:drWorkPath')
		packadd dailyReading
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
