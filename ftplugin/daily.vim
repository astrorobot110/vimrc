scriptencoding utf-8

lcd %:h
let g:dailyMoverLs = glob('*.md', 0, 1)->sort()

if index(g:dailyMoverLs, expand('%:t')) < 0
	call add(g:dailyMoverLs, expand('%:t'))->sort()
endif

nnoremap <buffer> <silent> [d :<C-u>call dailyMover#moveRelative(v:count == 0 ? -1 : -v:count)<CR>
nnoremap <buffer> <silent> ]d :<C-u>call dailyMover#moveRelative(v:count == 0 ? 1 : v:count)<CR>
nnoremap <buffer> <silent> [D :<C-u>call dailyMover#moveAbsolute(v:count == 0 ? -1 : -v:count)<CR>
nnoremap <buffer> <silent> ]D :<C-u>call dailyMover#moveAbsolute(v:count == 0 ? 1 : v:count)<CR>
nnoremap <buffer> <silent> [<C-d> :<C-u>call dailyMover#open(g:dailyMoverLs[0])<CR>
nnoremap <buffer> <silent> ]<C-d> :<C-u>call dailyMover#open(g:dailyMoverLs[-1])<CR>
nnoremap <buffer> <expr> <silent> Zo dailyMover#makeURI(expand('%:p'))
