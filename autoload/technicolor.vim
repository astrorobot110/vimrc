scriptencoding utf-8

let s:cpo = &cpoptions

set cpo&vim

let s:gray2rgb = {
		\ '95': 43,
		\ '135': 86,
		\ '175': 129,
		\ '215': 172
		\ }

let s:name2term = {
		\ 'orange': 214,
		\ 'purple': 129,
		\ 'violet': 213,
		\ 'seagreen': 29,
		\ 'slateblue': 62
		\ }

let s:colorName = [
		\ 'bg', 'BackGround', 'fg', 'ForeGround', 'Black',
		\ 'DarkRed', 'DarkGreen', 'DarkYellow', 'Brown', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray', 'Grey',
		\ 'DarkGray', 'DarkGrey', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
		\ 'LightGray', 'LightGrey', 'lightRed', 'LightGreen', 'LightYellow', 'LightBlue', 'LightMagenta', 'LightCyan'
		\ ]

function! s:gui2term(guiColor) abort
	if a:guiColor =~ '^#\?\x\{6}$'
		let rgbList = matchlist(a:guiColor, '\v^#(\x\x)(\x\x)(\x\x)')[1:3]
				\ ->map({_, val ->str2nr(val, 16)})

		if len(uniq(copy(rgbList))) == 1
			return s:gray2term(rgbList[0])
		endif

		return s:rgb2term(rgbList)
	elseif has_key(s:name2term, tolower(a:guiColor))
		return s:name2term[tolower(a:guiColor)]
	elseif match(s:colorName, '^'..a:guiColor..'$') > 0
		return a:guiColor
	else
		return 'NONE'
	endif
endfunction

function! s:rgb2term(rgbList) abort
	for value in a:rgbList
		let termColor = get(l:, 'termColor', 0)*6
		if value >= 75
			let termColor += ((value-75)/40)+1
		endif
	endfor

	return termColor+16
endfunction

function! s:gray2term(level) abort
	if a:level <= 3
		return 16
	elseif a:level >= 243
		return 231
	elseif has_key(s:gray2rgb, a:level)
		return s:gray2rgb[a:level]
	endif

	let step = sort([0, (a:level-3)/10, 23], 'n')[1]

	return step+232
endfunction

function! s:term2gui(termColor) abort
	if a:termColor < 0 || a:termColor > 255
		return 'NONE'
	elseif a:termColor <= 15
		return s:term2sysRgb(a:termColor)
	elseif a:termColor >= 232
		return s:term2gray(a:termColor-232)
	elseif str2nr(a:termColor) > 0
		return s:term2rgb(a:termColor-16)
	elseif match(s:colorName, '^'..a:termColor..'$') > 0
		return a:termColor
	endif
	return 'NONE'
endfunction

function! s:term2sysRgb(termColor) abort
	if a:termColor == 7
		return '#C0C0C0'
	elseif a:termColor == 8
		return '#808080'
	elseif a:termColor < 7
		let value = '80'
	else
		let value = 'FF'
	endif

	let rgb = '#'

	for div in [1, 2, 4]
		let rgb .= (a:termColor/div)%2 == 0 ? '00' : value
	endfor

	return rgb
endfunction

function! s:term2gray(termColor) abort
	let rgb = printf('%02X', a:termColor*10+8)
	return '#'..repeat(rgb, 3)
endfunction

function! s:term2rgb(termColor) abort
	let value = ['00', '5F', '87', 'AF', 'D7', 'FF']
	let rgb = '#'

	for div in [36, 6, 1]
		let rgb .= value[(a:termColor/div)%6]
	endfor

	return rgb
endfunction

command! -nargs=1 Tech2Term echo s:gui2term(<q-args>)
command! -nargs=1 Tech2Gui echo s:term2gui(<q-args>)

let &cpo = s:cpo
