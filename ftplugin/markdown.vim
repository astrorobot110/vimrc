" Open with Previm
nnoremap <buffer> gx :<C-u>PrevimOpen<CR>

if match(expand('%:p'), 'obsidian[\\\/]daily') >= 0
	call dailyMover#load()
endif

