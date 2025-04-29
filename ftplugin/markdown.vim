" Prevent recomended style
let g:markdown_recommended_style = 0
setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

let path = expand('%:p')->substitute('\\', '\/', 'g')
let pattern = expand(g:private.memo)->substitute('\\', '\/', 'g')
let obsidianUri = 'obsidian://open?vault=obsidian&file='

if match(path, pattern->escape('/')) == 0
" Open with Obsidian
	call printf('nnoremap <buffer> gx :<C-u>silent !explorer "%s"<CR>', obsidianUri..substitute(path, pattern..'/'->escape('/'), '', ''))->execute()
else
" Open with Previm
	nnoremap <buffer> gx :<C-u>PrevimOpen<CR>
endif

if match(path, pattern..'/daily'->escape('/')) == 0
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

	nnoremap <buffer> Zu $vi("*p
	nnoremap <buffer> Zl $ciW["](*)

	command -range -buffer Tsuken call dailyReport#formatter(<line1>, <line2>)
endif
