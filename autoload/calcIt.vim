scriptencoding utf-8

function calcIt#main() abort
	let formula = matchstr(getline('.'), '^=\?\zs.*')
	let answer = eval(formula)
	if mode() ==? 'i'
		return "\n=".string(answer)
	else
		call append(line('.'), '='.string(answer))
	endif
endfunction
