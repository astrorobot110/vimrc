scriptencoding utf-8

let s:pi = acos(-1)

let s:rad = { deg -> deg * s:pi / 180 }
let s:deg = { rad -> rad * 180 / s:pi }

function s:toPolar(width, height) abort
	let range = sqrt(pow(a:width, 2) + pow(a:height, 2))
	let angle = s:deg(atan2(a:height, a:width))

	let calc = [
		\ printf('%7s: %8.2f', 'range', range),
		\ printf('%7s: %8.2fﾟ', 'angle', angle),
		\ ]

	return calc
endfunction

function s:toRect(range, angle) abort
	let width = a:range * cos(s:rad(a:angle))
	let height = a:range * sin(s:rad(a:angle))

	let calc = [
		\ printf('%7s: %8.2f', 'width', width),
		\ printf('%7s: %8.2f', 'height', height),
		\ ]

	return calc
endfunction

function! s:putResult(result) abort
	if getline('.') !=# ''
		call insert(a:result, '')
	endif

	if strlen(getline(1,'$')->join()) > 0
		call append(line('.'), a:result)
	else
		call setline(1, a:result)
	endif

	call setpos('.', [bufnr(), line('.')+len(a:result), 0])
endfunction

function! jig#step(offset, pitch, param, bang) abort
	let offset = str2float(a:offset)
	let pitch = str2float(a:pitch)
	if a:bang ==# ''
		let param = str2float(a:param)
		let paramName = 'length'
		let length = param
	else
		let param = str2float(a:param)
		let paramName = 'step'
		let length = offset + pitch * param
	endif

	let calc = [
		\ printf('%7s: %7.1f', 'offset', offset),
		\ printf('%7s: %7.1f', 'pitch', pitch),
		\ printf('%7s: %7.1f', paramName, param),
		\ '------------------'
		\ ]
	let index = 0
	let point = offset

	while point < length
		call add(calc, printf('%7d: %7.1f', index, point))
		let point += pitch
		let index += 1
	endwhile

	call add(calc, printf('%7d: %7.1f', index, length))
	call s:putResult(calc)
endfunction

function! jig#polar(paramX, paramY, bang) abort
		let paramX = str2float(a:paramX)
		let paramY = str2float(a:paramY)
	if a:bang ==# ''
		let paramXName = 'width'
		let paramYName = 'height'
		let paramYUnit = ''
		let calc = s:toPolar(paramX, paramY)
	else
		let paramXName = 'range'
		let paramYName = 'angle'
		let paramYUnit = 'ﾟ'
		let calc = s:toRect(paramX, paramY)
	endif

	let calcPre = [
		\ printf('%7s: %7.1f', paramXName, paramX),
		\ printf('%7s: %7.1f%s', paramYName, paramY, paramYUnit),
		\ '------------------'
		\ ]

	call s:putResult(calcPre + calc)
endfunction
