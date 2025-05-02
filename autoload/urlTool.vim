scriptencoding utf-8

let s:urlPattern = 'https\?:\/\/[a-zA-Z0-9_\/\.,\!?~@#$%&\*\-+='']\+'

" 正規表現分からなすぎるので可読性用
let s:readableRegex = [
			\	{
			\		'pre':  '\[.\{-}](',
			\		'url':  '.\{-}',
			\		'post': ')'
			\	},
			\	{
			\		'pre':  '<',
			\		'url':  '.\{-}',
			\		'post':	'>'
			\	},
			\	{
			\		'pre':  '',
			\		'url':  s:urlPattern,
			\		'post': ''
			\	}
			\]

let s:regex = '\('..map(s:readableRegex, { _, val -> printf('\(%s\)%s\(%s\)', val.pre, val.url, val.post) })->join('\|')..'\)'

" 確認用
" let g:urlPattern#regex = s:regex

function! urlTool#replaceLink(visualmode = 0) abort
	let line = getline('.')
	let pos = getpos('.')[2]

	let linkRegion = { 'first': match(line, s:regex), 'last': matchend(line, s:regex)+1 }

	if
				\ linkRegion.first > 0 &&
				\ ( linkRegion.first < pos && pos < linkRegion.last )
		call substitute(line, s:regex, printf('\2\4%s\3\5', @*), '')->setline('.')
	else
		if a:visualmode == 1
			if visualmode() ==# 'V'
				let pattern = line
			else
				let region = { 'first': getpos("'<"), 'last': getpos("'>") }
				let pattern = getregion(region.first, region.last, { 'type': 'v' })->join('\r')
			endif
		else
			let currentRegister = getreg('"', 1)
			normal yiw
			let pattern = getreg('"', 1)
			call setreg('"', currentRegister)
		endif

		let pattern = pattern->escape('^$.*[]/~\')
		call substitute(line, printf('\(%s\)', pattern), printf('[\1](%s)', @*), '')->setline('.')
	endif
endfunction

