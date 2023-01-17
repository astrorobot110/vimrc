scriptencoding utf-8

function! calcIt#main() abort
	let answer = eval(substitute(getline('.'), '^=', '', 'e'))
	try
		if mode() ==? 'i'
			return "\n"..answer
		else
			call append('.', '='..answer)
			call setpos('.', [0, getcurpos()[1]+1, len(getline(line('.'))), 0])
		endif
	catch /E\(15\|121\)/
		echo '=42.0'
		return ''
	endtry
endfunction

nnoremap <plug>(calcIt-inNormal) :<C-u>call calcIt#main()<CR>
inoremap <expr> <plug>(calcIt-inInsert) calcIt#main()
