scriptencoding utf-8

function calcIt#main() abort
	let formula = eval(getline('.'))
	if mode() ==? 'i'
		return "\n=".string(formula)
	else
		call append(line('.'), string(formula))
	endif
endfunction
