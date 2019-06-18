scriptencoding utf-8

let s:browserExe = g:browser
let s:searchEngine = 'https://www.google.com/search?q='

function! s:toBrowser(searchWord) abort
	let isPowershell = &shell ==? 'powershell' ? '&' : ''
	let address = a:searchWord ==# '' ? shellescape(expand('%:p')) : shellescape(s:searchEngine.a:searchWord)
	return system(join([isPowershell, shellescape(s:browserExe), address], ' '))
endfunction

command! -nargs=? Browse call s:toBrowser('<f-args>')
