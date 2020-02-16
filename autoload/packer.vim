scriptencoding utf-8

function! packer#main() abort
	if exists('g:qcExe') && exists('g:qcPath') && exists('$QIITA_ACCESS_TOKEN')
		packadd qiitactl
	endif

	if g:isDroid || g:isTermux
		packadd gboard
	endif
endfunction
