scriptencoding utf-8

let s:cpo = &cpoptions

set cpo&vim

let s:gray2color = {
		\ '95': 43,
		\ '135': 86,
		\ '175': 129,
		\ '215': 172
		\ }

let s:name2cterm = {
		\ 'orange': 214,
		\ 'purple': 129,
		\ 'violet': 213,
		\ 'seagreen': 29,
		\ 'slateblue': 62
		\ }

let s:targetDict = {'cterm': 'gui', 'gui': 'cterm'}

let s:colorName = [
		\ 'bg', 'BackGround', 'fg', 'ForeGround', 'Black',
		\ 'DarkRed', 'DarkGreen', 'DarkYellow', 'Brown', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray', 'Grey',
		\ 'DarkGray', 'DarkGrey', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
		\ 'LightGray', 'LightGrey', 'lightRed', 'LightGreen', 'LightYellow', 'LightBlue', 'LightMagenta', 'LightCyan'
		\ ]

let s:rgbValue = ['00', '5F', '87', 'AF', 'D7', 'FF']

let s:technicolor = {
		\ 'order': ['ctermfg', 'ctermbg', 'cterm', 'guifg', 'guibg', 'gui'],
		\ 'command': 'hi',
		\ 'preWidth': 16,
		\ 'width': 16,
		\ 'blank': "\t\t\t\t"
		\ }

function! s:gui2cterm(guiColor) abort
	if a:guiColor =~ '^#\?\x\{6}$'
		let rgbList = matchlist(a:guiColor, '\v^#(\x\x)(\x\x)(\x\x)')[1:3]
				\ ->map({_, val ->str2nr(val, 16)})

		if len(uniq(copy(rgbList))) == 1
			return s:gray2cterm(rgbList[0])
		endif

		return s:rgb2cterm(rgbList)
	elseif has_key(s:name2cterm, tolower(a:guiColor))
		return s:name2cterm[tolower(a:guiColor)]
	elseif match(s:colorName, '^'..a:guiColor..'$') > 0
		return a:guiColor
	else
		return 'NONE'
	endif
endfunction

function! s:rgb2cterm(rgbList) abort
	for value in a:rgbList
		let ctermColor = get(l:, 'ctermColor', 0)*6
		if value >= 75
			let ctermColor += ((value-75)/40)+1
		endif
	endfor

	return ctermColor+16
endfunction

function! s:gray2cterm(level) abort
	if a:level <= 3
		return 16
	elseif a:level >= 243
		return 231
	elseif has_key(s:gray2color, a:level)
		return s:gray2color[a:level]
	endif

	let step = sort([0, (a:level-3)/10, 23], 'n')[1]

	return step+232
endfunction

function! s:cterm2gui(ctermColor) abort
	if a:ctermColor < 0 || a:ctermColor > 255
		return 'NONE'
	elseif a:ctermColor <= 15
		return s:cterm2sysRgb(a:ctermColor)
	elseif a:ctermColor >= 232
		return s:cterm2gray(a:ctermColor-232)
	elseif str2nr(a:ctermColor) > 0
		return s:cterm2rgb(a:ctermColor-16)
	elseif match(s:colorName, '^'..a:ctermColor..'$') > 0
		return a:ctermColor
	endif
	return 'NONE'
endfunction

function! s:cterm2sysRgb(ctermColor) abort
	if a:ctermColor == 7
		return '#C0C0C0'
	elseif a:ctermColor == 8
		return '#808080'
	elseif a:ctermColor < 7
		let value = '80'
	else
		let value = 'FF'
	endif

	let rgb = '#'

	for div in [1, 2, 4]
		let rgb .= (a:ctermColor/div)%2 == 0 ? '00' : value
	endfor

	return rgb
endfunction

function! s:cterm2gray(ctermColor) abort
	let rgb = printf('%02X', a:ctermColor*10+8)
	return '#'..repeat(rgb, 3)
endfunction

function! s:cterm2rgb(ctermColor) abort
	let rgb = '#'

	for div in [36, 6, 1]
		let rgb .= s:rgbValue[(a:ctermColor/div)%6]
	endfor

	return rgb
endfunction

function! technicolor#main(args) abort
	if !exists('b:technicolor')
		let b:technicolor = deepcopy(s:technicolor)
	endif

	let [env, ground, value] = matchlist(a:args, '\v(cterm|gui)(fg|bg|)\=(.+)')[1:3]

	let target = s:targetDict[tolower(env)]

	if ground != ''
		let targetValue = funcref(printf('s:%s2%s', env, target))(value)
	else
		let targetValue = value
	endif

	let currentLine = substitute(
			\ getline('.'),
			\ env..ground..'=\zs\S\+',
			\ value,
			\ ''
			\ )
	let currentLine = substitute(
			\ currentLine,
			\ target..ground..'=\zs\S\+',
			\ targetValue,
			\ ''
			\ )

	call setline('.', currentLine)

	return
endfunction

command! -nargs=1 Tech2cterm echo s:gui2cterm(<q-args>)
command! -nargs=1 Tech2gui echo s:cterm2gui(<q-args>)
command! -nargs=1 Technicolor call technicolor#main(<q-args>)

let &cpo = s:cpo
