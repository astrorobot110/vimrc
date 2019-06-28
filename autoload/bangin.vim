scriptencoding utf-8

function! bangin#bang() abort
	return ':'.substitute(@:, '\v( |$)', '!\1', 'e')
endfunction

function! bangin#slam() abort
	return ':'.toupper(@:[0]).@:[1:]
endfunction

function! bangin#pang() abort
	return ':'.split(@:, ' ')[0].' "'.join(split(@:, ' ')[1:], ' ').'"'
endfunction

function! bangin#flip() abort
	return ':!'.@:
endfunction
