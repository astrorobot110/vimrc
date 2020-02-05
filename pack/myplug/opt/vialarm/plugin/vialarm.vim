scriptencoding utf-8

command! -bang -nargs=* -complete=command Vialarm call vialarm#main(<q-args>, '<bang>')

augroup vialarm_system
	autocmd!
	autocmd FocusGained * call vialarm#stackedAlarm()
augroup END

Vialarm! start
