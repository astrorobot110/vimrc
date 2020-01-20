scriptencoding utf-8

let s:dailySaveDir = exists('g:dailySaveDir') ? g:dailySaveDir : '~/dailySave'

if !isdirectory(expand(s:dailySaveDir))
	call mkdir(expand(s:dailySaveDir))
endif

function! dailySave#main() abort
	if bufname() ==# ''
		call execute(printf('write! %s/%s.md', expand(s:dailySaveDir), strftime('%y%m%d')))
		echo 'Dailysaved.'
	endif
endfunction
