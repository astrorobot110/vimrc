scriptencoding utf-8

" 旧diffexpr

function! mydiff#main()
	let diffExec = $VIM.'\vim81\diff.exe'
	let opt = ''
	if &diffopt =~# 'icase'
		let opt = opt . ' -i'
	endif
	if &diffopt =~# 'iwhite'
		let opt = opt . ' -b'
	endif
	call writefile(systemlist(printf('%s -a --binary %s %s %s', diffExec, opt, v:fname_in, v:fname_new)), v:fname_out)
endfunction
