scriptencoding utf-8

let s:cpo = &cpoptions

command! -nargs=* -complete=command Vialarm call vialarm#alarm(<q-args>)
command! -nargs=* -complete=command Vitimer call vialarm#timer(<q-args>)

augroup vialarm_system
	autocmd!
	autocmd FocusGained * call vialarm#stackedAlarm()
augroup END

let &cpoptions = s:cpo
