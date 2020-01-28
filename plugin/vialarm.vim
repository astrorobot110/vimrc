scriptencoding utf-8

command VialarmInit call vialarm#init()
command VialarmList echo vialarm#showList()

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd user 17:00 call s:dailySave()
	endif
	autocmd user 20:00 call s:nenaiko()
augroup END

VialarmInit

function! s:dailySave() abort
	if bufname() ==# ''
		cd $INTERNAL_STORAGE/Documents/git/memo/dailySave
		call execute(printf('write! %s.md', strftime('%y%m%d')))
		echo system('git add '.expand('%'))
		echo system('git commit -m ''dailysaved.''')
		echo system('git push')
	endif
endfunction

function! s:nenaiko() abort
	echo 'ねないこだれだ'
endfunction
