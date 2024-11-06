scriptencoding utf-8

" autoIM
augroup autoIM
	autocmd!
	autocmd ModeChanged *:n set iminsert=0
augroup END

" autoYank for TEA
if has('clientserver') && v:servername =~? 'VIM_TEA\d*$'
	augroup autoYank
		autocmd!
		autocmd ExitPre * normal ggVG"+y
		autocmd ExitPre * write! ~/Desktop/TEAbackup
	augroup END
endif

" save state via mkview/loadview (testing)
" augroup loadviewer
" 	autocmd BufWinLeave * silent! mkview
" 	autocmd BufWinEnter * silent! loadview
" augroup END

" Some trick in colorscheme.
augroup customColorscheme
	autocmd!
	autocmd ColorScheme * call customCS#main()
augroup END

" backup回り
augroup backupdir
	autocmd!
	autocmd BufWritePre * ++once call s:chkBackupDir()

	function s:chkBackupDir() abort
		if !expand(&backupdir)->isdirectory()
			let option = has('win32') ? '' : '-p'
			let g:test = system(printf('mkdir %s %s', option, &backupdir))
		endif
	endfunction
augroup END

if v:version >= 900
	augroup diffWindow
		autocmd!
		autocmd WinScrolled * call s:diffWindow()

		function s:diffWindow () abort
			if &columns < 80
				set diffopt+=vertical
			else
				set diffopt-=vertical
			endif
		endfunction
	augroup END
endif
