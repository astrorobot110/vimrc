scriptencoding utf-8

packadd vialarm
Vialarm! start

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User Vialarm_17:00 call s:dailySave()
	endif
augroup END

function! s:dailySave(...) abort
	let currentBuf = bufnr()
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:dailySaveDir)
	let fileName = strftime('%y%m%d.md', localtime())

	if bufname(bufnr()) ==# ''
		execute 'write! >>' join([path, fileName], '/')
	endif
endfunction
