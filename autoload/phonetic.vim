scriptencoding utf-8

let s:phone = [
				\ "Alfa", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot",
				\ "Golf", "Hotel", "India", "Juliett", "Kilo", "Lima",
				\ "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo",
				\ "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "Xray",
				\ "Yankee", "Zulu"
			\ ]

function phonetic#generate(arg = 1) abort
	let content = []

	if type(a:arg) == v:t_number
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

	return join(content, "-")
endfunction

function phonetic#main(arg = 1, isBang = "") abort
	let content = phonetic#generate(a:arg)

	if a:isBang !=? "!"
		call append(".", content)
	else
		call setline(".", printf("%s %s", getline("."), content))
	endif

	return
endfunction
