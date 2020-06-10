scriptencoding utf-8

function! calcIt#main(...) abort
	let formula = len(join(a:000)) > 0 ? join(a:000) : matchstr(getline('.'), '^=\?\zs.*')
	let answer = len(join(a:000)) > 0 ? [ formula ] : []

	try
		call add(answer, '='..string(eval(formula)))

		if mode() ==? 'i'
			return "\n"..answer[-1]
		else
			call append(line('.'), answer)
		endif
	catch /E\(15\|121\)/
		echo '=42.0'
		return ''
	endtry
endfunction
