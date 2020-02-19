scriptencoding utf-8

packadd vialarm
Vialarm! start

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User Vialarm_17:00 s:dailySave
	endif
augroup END

function! dailySave(...) abort
	let currentBuf = bufnr()
	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:dailySaveDir)
	let fileName = strftime('/%y%m%d.md', localtime())

	execute 'cd' path
	for buf in range(1, bufnr('$')
		try
			if bufname(buf) ==# ''
