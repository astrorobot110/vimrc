scriptencoding utf-8

" autoIM
augroup autoIM
	autocmd!
	autocmd InsertLeave * set iminsert=0
	autocmd CmdlineLeave * set iminsert=0
augroup END

" autoYank for TEA
if has('clientserver') && v:servername =~? 'VIM_TEA\d*$'
	augroup autoYank
		autocmd!
		autocmd ExitPre * normal ggVG"+y
		autocmd ExitPre * write! ~/Desktop/TEAbackup
	augroup END
endif

" 脱初心者を目指すVimmerにオススメしたいVimプラグインや.vimrcの設定
" https://qiita.com/jnchito/items/5141b3b01bced9f7f48f#最後のカーソル位置を復元する
augroup lastCursor
	autocmd!
	autocmd BufReadPost * call s:lastCursor()

	function s:lastCursor() abort
		if line("'\"") > 0 && line ("'\"") <= line("$")
			execute "normal! g'\""
		endif
	endfunction
augroup END

" autoloader
if ( v:servername == '' ) || ( v:servername =~? '^G\?VIM\d*$' && len(v:argv) <= 1 )
	augroup autoLoader
		autocmd!
		autocmd VimEnter * call s:autoLoader()
	augroup END

	function s:autoLoader() abort
		edit #<1
		filetype detect
	endfunction
endif
