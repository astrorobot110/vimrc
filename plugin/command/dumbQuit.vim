scriptencoding utf-8

if has('clientserver') && v:servername =~? 'GVIM\d*$' && has('patch-8.0.1595')
	augroup dumbQuit
		autocmd!
		au ExitPre * call dumbQuit#main()
	augroup END
endif
