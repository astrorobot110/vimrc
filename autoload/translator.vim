scriptencoding utf-8

function! s:getUrl() abort
	let vars = expand('$vimrc/.private/translator.vim')
	call printf('source %s', vars)->execute()

	return g:translatorUrl
endfunction

function! s:urlEncode(text) abort
python3 << EOF
import urllib.parse
import vim

enc = urllib.parse.quote(vim.eval('a:text'))
command = 'let enc = "%s"' % enc
vim.command(command)
EOF
	return enc
endfunction

function! translator#translate(text, langFrom = '', langTo = '') abort
	if !exists('g:translatorUrl')
		call s:getUrl()
	endif

	let text = s:urlEncode(a:text)
	let source =   a:langFrom == '' ? 'en' : a:langFrom
	if source != 'ja'
		let target = a:langTo == '' ? 'ja' : s:langTo
	else
		let target = a:langTo == '' ? 'en' : s:langTo
	endif

	let query =  printf('text=%s&source=%s&target=%s', text, source, target)
	let url = printf('%s?%s', g:translatorUrl, query)

	let command = printf('curl -s -L ''%s''', url)
	let response = system(command)->json_decode()

	return response
endfunction

function! translator#encTest(text) abort
	return s:urlEncode(a:text)
endfunction
