scriptencoding utf-8

command -bang -nargs=* -complete=command Vialarm call vialarm#main(<q-args>, '<bang>')
command VialarmStart call vialarm#timerSwitch('start')
command VialarmStop call vialarm#timerSwitch('stop')

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User vialarm_17:00 call s:dailySave()
	endif
	autocmd User vialarm_20:00 call s:nenaiko(20)
	autocmd User vialarm_22:00 call s:nenaiko(22)
augroup END

Vialarm! start

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
