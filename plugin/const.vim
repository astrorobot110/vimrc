scriptencoding utf-8

let g:pi = acos(-1)

function! Rad(deg, ...) abort
	return a:deg * g:pi / 180
endfunction

function! Deg(rad, ...) abort
	return a:rad * 180 / g:pi
endfunction
