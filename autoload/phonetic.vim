scriptencoding utf-8

let s:phone = [
				\ "Alfa", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot",
				\ "Golf", "Hotel", "India", "Juliett", "Kilo", "Lima",
				\ "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo",
				\ "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "Xray",
				\ "Yankee", "Zulu"
			\ ]

function s:generate(length = 1) abort
	let content = []
	for n in range(a:length)
		let content += [ s:phone[rand() % len(s:phone)] ]
	endfor

	return join(content, "-")
endfunction

function phonetic#main(length = 1, isBang = "") abort
	let content = s:generate(a:length)
	if a:isBang !=? "!"
		call append(".", content)
	else
		call setline(".", printf("%s %s", getline("."), content))
	endif

	return
endfunction
