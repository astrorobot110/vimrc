scriptencoding utf-8

function knytt#ini2md() abort
	%substitute/\v^\[(.{,})\]$/# \1\r/ge
	%substitute/\v^(.{-})\s+0\=\s*/## \1\r\r/ge
	%substitute/\v^(.{-})\s+\d+\=\s*//ge
	%substitute/|/ | /ge
	%substitute/^(\(.\{-1,}\))/\1: /ge
endfunction
