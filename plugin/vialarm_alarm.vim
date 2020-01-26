scriptencoding utf-8

let g:vialarm_timeZone = 9

augroup vialarm
	autocmd!
	autocmd user 22:00 echo 'test'
	autocmd user 12:00 echo '正午！'
augroup END
