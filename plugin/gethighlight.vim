scriptencoding utf-8

" 設定しやすい用関数群

function! GetHl(name, ...) abort
	let isBang = a:0 > 0 ? a:1 : ''
	let name = a:name

	while !exists('hlList') || hlList[0] ==? 'links'
		let hlList = split(execute('highlight ' . name), '\s\+')[2:]
		if hlList[0] ==? 'links'
			if mode() ==? 'n'
				echo printf('Highlight ''%s'' is links to ''%s''.', name, hlList[-1])
			endif
			let name = hlList[-1]
		endif
	endwhile

	let hlDict = {'name': name}

	for n in hlList
		let [ dKey, dValue ] = split(n, '=')
		let hlDict[dKey] = dValue
	endfor

	if isBang ==# '!'
		call append(line('.')-1, join(['highlight', name, join(hlList)]))
	elseif mode() ==? 'n'
		echo join(['highlight', name, join(hlList)])
	endif

	return hlDict
endfunction

command -nargs=1 -bang -complete=highlight GetHl call GetHl(<q-args>, '<bang>')
