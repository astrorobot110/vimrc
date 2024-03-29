scriptencoding utf-8

" フォント
if has('win32')
	try
		set guifont=Moralerspace_Argon_HWJPDOC:qANTIALIASED:h12
	catch \E596\
		set guifont=UDEV\ Gothic\ NF:qANTIALIASED:h12
	endtry
	set renderoptions=type:directx,renmode:5
	set linespace=2
elseif has('unix')
	set guifont=UDEV\ Gothic\ NF\ 12
	set linespace=1
endif

" guiのI/F関係
set guioptions=c!
set winaltkeys=no

set columns=161
set lines=42
" Hack #120: gVim でウィンドウの位置とサイズを記憶する
" http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html
" let g:save_window_file = expand($VIMFILES.'/.vimwinpos')
" augroup SaveWindow
" 	autocmd!
" 	autocmd VimLeavePre * call s:save_window()
" 	function! s:save_window()
" 		let options = [
" 			\ 'set columns=' . &columns,
" 			\ 'set lines=' . &lines,
" 			\ 'winpos ' . getwinposx() . ' ' . getwinposy(),
" 			\ ]
" 		call writefile(options, g:save_window_file)
" 	endfunction
" augroup END
" 
" if filereadable(g:save_window_file)
" 	execute 'source' g:save_window_file
" endif
