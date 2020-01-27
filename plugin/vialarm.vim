scriptencoding utf-8

let g:vialarm_timeZone = 9

command VialarmInit call vialarm#init()
command VialarmList echo vialarm#showList()

augroup vialarm
	autocmd!
augroup END

VialarmInit
