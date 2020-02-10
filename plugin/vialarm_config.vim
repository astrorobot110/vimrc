scriptencoding utf-8

packadd vialarm

augroup vialarm
	autocmd!
	if $VIMDEVICE ==# 'xperia_mobile'
		autocmd User Vialarm_17:00 DailySave
	endif
augroup END
