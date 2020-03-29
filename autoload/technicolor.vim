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
		\ 'Orange': 214,
		\ 'Purple': 129,
		\ 'Violet': 213,
		\ 'SeaGreen': 29,
		\ 'SlateBlue': 62
		\ }

let s:colorName = [
		\ 'bg', 'BackGround', 'fg', 'ForeGround', 'Black',
		\ 'DarkRed', 'DarkGreen', 'DarkYellow', 'Brown', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray', 'Grey',
		\ 'DarkGray', 'DarkGrey', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
		\ 'LightGray', 'LightGrey', 'lightRed', 'LightGreen', 'LightYellow', 'LightBlue', 'LightMagenta', 'LightCyan'
		\ ]

function! s:getGuiColor(guiColor) abort
	if a:guiColor =~ '^#\?\x\{6}$'
		let color = matchlist(a:guiColor, '\v^#(\x\x)(\x\x)(\x\x)')[1:3]
				\ ->map({_, val ->eval('0x'..val)})

		if len(uniq(copy(color))) == 1
			return s:gray2term(color[0])
		endif

		return s:rgb2term(color)
	elseif a:guiColor ==# 'NONE' || match(s:colorName, '^'..a:guiColor..'$') > 0
		return s:colorName[match(s:colorName, '^'..a:guiColor..'$')]
	else
		return -1
	endif
endfunction

function! s:rgb2term(rgb) abort
	for value in a:rgb
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

command! -nargs=1 Tech2Term echo s:getGuiColor(<q-args>)

let &cpo = s:cpo
