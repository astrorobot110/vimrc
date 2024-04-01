" Open with Previm
nnoremap <buffer> gx :<C-u>PrevimOpen<CR>

if match(expand('%:p'), 'obsidian[\\\/]daily') >= 0
	call dailyMover#load()

	nnoremap <buffer> <silent> [d :<C-u>call dailyMover#move(v:count == 0 ? -1 : -v:count)<CR>
	nnoremap <buffer> <silent> ]d :<C-u>call dailyMover#move(v:count == 0 ? 1 : v:count)<CR>
endif

