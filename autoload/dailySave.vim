scriptencoding utf-8

let s:dailySaveDir = exists('g:dailySaveDir') ? g:dailySaveDir : '~/Documents/dailySave'

function! dailySave#main(path) abort
	try
		let currentBuf = bufnr()
		let fileName = strftime('%y%m%d.md', localtime())
		let path = isdirectory(expand(a:path)) ? a:path : s:dailySaveDir
		if !isdirectory(expand(path))
			throw 'dailySave_E01'
		endif
		execute 'cd' path
		for buf in range(1, bufnr('$'))
			try
				if bufname(buf) ==# ''
					execute 'buffer!' buf
					execute 'write! >>' fileName
				endif
			catch /E86/
				continue
			endtry
		endfor

		if getftype(fileName) !=# ''
			!git add *
			!git commit -m "Dailysaved."
			!git push
		endif

		cd -
		execute 'buffer!' currentBuf
	catch /E216/
		echoerr printf('Failed in ''cd %s''', a:path)
	catch /dailySave_E01/
		echoerr 'No dailysave directory.'
	endtry
endfunction
