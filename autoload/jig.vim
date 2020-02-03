scriptencoding utf-8

let s:pi = 3.1415

function! s:toRad(degree) abort
	return (a:degree/180) * s:pi
endfunction

function! s:toDeg(radian) abort
	return (a:radian/s:pi) * 180
endfunction

function! jig#appender(funcName, ...) abort
	let Jig = function('jig#'.a:funcName, a:000)
	let putLine = line('.') == 1 ? 0 : line('.')
	if putLine != 0
		call append(line('.'), '')
		call setpos('.', [bufnr(), putLine+1, 0])
	endif
	call append(putLine, split(Jig(), "\n"))
endfunction

function! jig#step(...) abort
	let [ offset, length, stride ] = map(copy(a:000)[0:2], {_,val -> str2float(val)})
	let calc = [
		\ printf('%7s: %8.1f', 'offset', offset),
		\ printf('%7s: %8.1f', 'length', length),
		\ printf('%7s: %8.1f', 'stride', stride),
		\ '------------------'
		\ ]
	let index = 1
	let point = offset

	while point < length
		call add(calc, printf('%7d: %8.1f', index, point))
		let point += stride
		let index += 1
	endwhile

	call add(calc, printf('%7d: %8.1f', index, length))
	return join(calc, "\n")
endfunction

function! jig#polar(...) abort
	let [ width, height ] = map(copy(a:000)[0:1], {_,val -> str2float(val)})
	let calc = [
		\ printf('%7s: %6.1f', 'width', width),
		\ printf('%7s: %6.1f', 'height', height),
		\ '-----------------'
		\ ]
	call add(calc, printf('%7s: %7.2f', 'range', sqrt(pow(width,2) + pow(height,2))))
	call add(calc, printf('%7s: %7.2fﾟ', 'angle', s:toDeg(atan2(height, width))))

	return join(calc, "\n")
endfunction

function! jig#rect(...) abort
	let [ range, angle ] = map(copy(a:000)[0:1], {_,val -> str2float(val)})
	let calc = [
		\ printf('%7s: %6.1f', 'range', range),
		\ printf('%7s: %6.1fﾟ', 'angle', angle),
		\ '-----------------'
		\ ]
	call add(calc, printf('%7s: %7.2f', 'width', range*(cos(s:toRad(angle)))))
	call add(calc, printf('%7s: %7.2f', 'height', range*(sin(s:toRad(angle)))))

	return join(calc, "\n")
endfunction
