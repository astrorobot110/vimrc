scriptencoding utf-8

packadd vialarm
Vialarm! start

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User Vialarm_17:00 DailySave
	endif
augroup END
