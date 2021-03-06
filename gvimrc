scriptencoding utf-8

" フォント
if g:isWin
	set guifont=HackGen:h12
	set renderoptions=type:directx,renmode:5
elseif g:isUnix
	set guifont=Hackgen\ Console\ 12
endif
set linespace=1

" guiのI/F関係
set guioptions=c!
set winaltkeys=no

"tokyonight用
let g:tokyonight_enable_italic = 1

if !g:isDroid
	set mouse=
endif

" Hack #120: gVim でウィンドウの位置とサイズを記憶する
" http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html
let g:save_window_file = expand($VIMFILES.'/.vimwinpos')
augroup SaveWindow
	autocmd!
	autocmd VimLeavePre * call s:save_window()
	function! s:save_window()
		let options = [
			\ 'set columns=' . &columns,
			\ 'set lines=' . &lines,
			\ 'winpos ' . getwinposx() . ' ' . getwinposy(),
			\ ]
		call writefile(options, g:save_window_file)
	endfunction
augroup END

if filereadable(g:save_window_file)
	execute 'source' g:save_window_file
endif
