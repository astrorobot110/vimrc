scriptencoding utf-8

function! Bbang() abort
	return ':'.substitute(@:, '\v( |$)', '!\1', 'e')
endfunction

function! Bslam() abort
	return ':'.toupper(@:[0]).@:[1:]
endfunction

function! Bpang() abort
	return ':'.split(@:, ' ')[0].' "'.join(split(@:, ' ')[1:], ' ').'"'
endfunction

function! Bflip() abort
	return ':!'.@:
endfunction
