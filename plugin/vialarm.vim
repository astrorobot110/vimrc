scriptencoding utf-8

command -bang -nargs=* -complete=command Vialarm call vialarm#main(<q-args>, '<bang>')

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile' && v:false
		autocmd user 17:00 call s:dailySave()
	endif
	autocmd user 20:00 call s:nenaiko(20)
	autocmd user 22:00 call s:nenaiko(22)
augroup END

Vialarm!

function! s:dailySave() abort
	if bufname() ==# ''
		cd $INTERNAL_STORAGE/Documents/git/memo/dailySave
		call execute(printf('write! %s.md', strftime('%y%m%d')))
		echo system('git add '.expand('%'))
		echo system('git commit -m ''dailysaved.''')
		echo system('git push')
	endif
endfunction

function! s:nenaiko(hour) abort
	if a:hour == 22
		echo 'ねないこだれだ'
	else
		echo 'はやくねなさい'
	endif
endfunction
