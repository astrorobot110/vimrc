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
if len(v:argv) <= 1
	augroup autoLoader
		autocmd!
		autocmd VimEnter * call s:autoLoader()

		function s:autoLoader() abort
			edit #<1
			filetype detect
		endfunction
	augroup END

endif

" Some trick in colorscheme 'janah'.
augroup cs-janah
	autocmd!
	autocmd ColorScheme janah call s:janah()

	function s:janah() abort
		" Terminal用
		highlight Normal ctermbg=235

		" ステータスライン調整
		highlight StatusLine term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermfg=216 ctermbg=16 guifg=#ffaf87 guibg=#3a3a3a

		" 分割線
		highlight VertSplit    term=reverse ctermfg=237 ctermbg=bg  guifg=#3a3a3a guibg=bg
		highlight CursorLineNr term=bold    ctermfg=110 ctermbg=240 guifg=#87afdf guibg=#585858

		" カーソルの色変更
		if has('multi_byte_ime')
			highlight CursorIM guifg=bg guibg=#87dfaf
		endif
	endfunction
augroup END

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
