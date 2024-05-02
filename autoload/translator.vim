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

function! s:translate(text, source, target) abort
	if !exists('g:translatorUrl')
		call s:getUrl()
	endif

	let text = s:urlEncode(a:text)

	let query =  printf('text=%s&source=%s&target=%s', text, a:source, a:target)
	let url = printf('%s?%s', g:translatorUrl, query)

	let command = printf('curl -s -L ''%s''', url)
	let response = system(command)->json_decode()
	let response.text = split(response.text, "\n")

	return response
endfunction

function! s:getParagraph()
	let pos = { 'start': getpos("'<"), 'end': getpos("'>") }
	let pos.end[2] = min([pos.end[2], len(getline(pos.end[1]))])

	let mode = mode()[0]
	if mode !~ '[vV]'
		let mode = visualmode()
	endif

	let opts = { 'type': mode }

	let region = getregion(pos.start, pos.end, opts)
	call map(region, { _, val -> trim(val) })
	let region = join(region, "\n")

	return region
endfunction

function! translator#main(range = 0, bang = '', langFrom = '', langTo = '') range abort
	let current = getpos('.')
	let visual = { 'from': getpos("'<"), 'to': getpos("'>") }

	if a:range == 0
		normal vip
		call setpos('.', current)
	endif

	let text = s:getParagraph()

	let source =   a:langFrom == '' ? 'en' : a:langFrom
	if source != 'ja'
		let target = a:langTo == '' ? 'ja' : a:langTo
	else
		let target = a:langTo == '' ? 'en' : a:langTo
	endif

	let translate = s:translate(text, source, target)

	if a:range == 0
		call setpos("'<", visual.from)
		call setpos("'>", visual.to)
	endif

	if a:bang == '!'
		call append(visual.to[1], [''] + translate.text)
	else
		echo join(translate.text, "\n")
	endif
endfunction

