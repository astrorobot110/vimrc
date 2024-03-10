scriptencoding utf-8

let s:phone = [
				\ 'Alfa', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot',
				\ 'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima',
				\ 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo',
				\ 'Sierra', 'Tango', 'Uniform', 'Victor', 'Whiskey', 'Xray',
				\ 'Yankee', 'Zulu'
			\ ]

function s:generate(arg) abort
	let content = []

	if str2nr(a:arg) > 0
		for n in range(a:arg)
			call add(content, s:phone[rand() % len(s:phone)])
		endfor
	elseif match(a:arg, '^\s*\a*\s*$') >= 0
		for n in trim(a:arg)->toupper()
			call add(content, s:phone[char2nr(n)-char2nr('A')])
		endfor
	else
		echoerr 'Args must be only number or alphabet.'
	endif

	return join(content, '-')
endfunction

function phonetic#main(arg = '', isBang = '') abort
	let content = s:generate(a:arg != '' ? a:arg : 1)

	if a:isBang !=? '!'
		echo content
	else
		call append('.', content)
	endif

	return
endfunction
