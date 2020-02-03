scriptencoding utf-8

function calcIt#main() abort
	let formula = eval(getline('.'))
	call append(line('.'), "\t=".string(formula))
endfunction
