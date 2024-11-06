scriptencoding utf-8

lcd %:h
let g:dailyReportLs = glob('*.md', 0, 1)->sort()

if index(g:dailyReportLs, expand('%:t')) < 0
	call add(g:dailyReportLs, expand('%:t'))->sort()
endif

nnoremap <buffer> <silent> [d :<C-u>call dailyReport#moveRelative(v:count == 0 ? -1 : -v:count)<CR>
nnoremap <buffer> <silent> ]d :<C-u>call dailyReport#moveRelative(v:count == 0 ? 1 : v:count)<CR>
nnoremap <buffer> <silent> [D :<C-u>call dailyReport#moveAbsolute(v:count == 0 ? -1 : -v:count)<CR>
nnoremap <buffer> <silent> ]D :<C-u>call dailyReport#moveAbsolute(v:count == 0 ? 1 : v:count)<CR>
nnoremap <buffer> <silent> [<C-d> :<C-u>call dailyReport#open(g:dailyReportLs[0])<CR>
nnoremap <buffer> <silent> ]<C-d> :<C-u>call dailyReport#open(g:dailyReportLs[-1])<CR>
nnoremap <buffer> <expr> <silent> Zo dailyReport#makeURI(expand('%:p'))

command -range -buffer Format call dailyReport#formatter(<line1>, <line2>)
