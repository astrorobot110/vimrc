scriptencoding utf-8

function calcIt#main() abort
	let formula = getline('.')
	call append(line('.'), "\t=".eval(formula))
endfunction
