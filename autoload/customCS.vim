scriptencoding utf-8

" トリガー引く用
function! customCS#loader(name) abort
	try
		call ccs_{a:name}#main()
		let mes = printf('Loaded ''%s'' custom script.', a:name)
		let isFound = 1
	catch /E117/
		let mes = printf('No custom script for ''%s''.', a:name)
		let isFound = 0
	finally
		if v:vim_did_enter
			redraw
			echomsg 'costomCSLoader: '.mes
		endif
	endtry

	return isFound
endfunction
