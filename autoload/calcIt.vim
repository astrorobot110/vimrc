scriptencoding utf-8

function calcIt#main() abort
	let formula = eval(getline('.'))
	if mode() ==? 'i'
		return "\n\t=".string(formula)
	else
		call append(line('.'), "\t=".string(formula))
	endif
endfunction
