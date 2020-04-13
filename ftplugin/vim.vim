" 何勝手にしてくれてんねん！

augroup customFt_vim
	autocmd!
	autocmd BufEnter,BufNewFile *.vim call s:customFt_vim()
augroup END

function! s:customFt_vim() abort
	setlocal formatoptions-=q
	setlocal textwidth=0
endfunction
