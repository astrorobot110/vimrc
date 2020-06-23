scriptencoding utf-8

if !v:vim_did_enter
	autocmd VimEnter * silent Vialarm start
endif

augroup vialarm
	autocmd!
	if exists('g:private.daily')
		autocmd User vialarm!17:00 call s:dailySave()
	endif
augroup END

function! s:dailySave(...) abort
	let g:isDailysaved = 1

	let path = a:0 > 0 && isdirectory(expand(a:1)) ? expand(a:1) : expand(g:private.daily)
	let fileName = strftime('%y%m%d.md', localtime())

	execute 'cd' path

	for buf in range(1, bufnr('$'))
		if bufexists(buf) && bufname(buf) ==# ''
			execute 'sbuffer' buf
			execute 'write! >>' fileName
			close!
		endif
	endfor

	if filereadable(fileName)
		execute 'tabe' fileName
	endif

	cd -
	echo 'dailesaved.'
endfunction
