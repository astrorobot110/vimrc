scriptencoding utf-8

let g:pi = acos(-1)

function! Rad(deg, ...) abort
	return a:deg * g:pi / 180
endfunction

function! Deg(rad, ...) abort
	return a:rad * 180 / g:pi
endfunction

function! Sin(deg, ...) abort
	return Rad(a:deg)->sin()
endfunction

function! Cos(deg, ...) abort
	return Rad(a:deg)->cos()
endfunction

function! Tan(deg, ...) abort
	return Rad(a:deg)->tan()
endfunction

function! Asin(float, ...) abort
	return asin(a:float)->Deg()
endfunction

function! Acos(float, ...) abort
	return acos(a:float)->Deg()
endfunction

function! Atan(float, ...) abort
	return tan(a:float)->Deg()
endfunction
