scriptencoding utf-8

let s:browserExe = g:browser
let s:searchEngine = 'https://www.google.com/search?q='

function! s:toBrowser(searchWord) abort
	let isPowershell = &shell =~? '\v(powershell|pwsh)' ? '&' : ''
	let address = a:searchWord ==# '' ? shellescape(expand('%:p')) : shellescape(s:searchEngine . substitute(a:searchWord, '\s', '%20', 'ge'))
	return system(join([isPowershell, shellescape(s:browserExe), address], ' '))
endfunction

command! -nargs=? Browse call s:toBrowser(<q-args>)
