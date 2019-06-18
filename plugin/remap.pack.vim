scriptencoding utf-8

if exists('g:packLoaded') && g:packloaded
	if exists(':OpenReading') == 2
		nnoremap Zr :<C-u>OpenReading
		nnoremap ZR :<C-u>OpenReading!
	endif

	if exists(':QiitaFiles') == 2
		nnoremap <Leader>qq :<C-u>QiitaFiles
	endif

	if exists(':Browse') == 2
		nnoremap Zx :<C-u>silent Browse<CR>
		nnoremap ZX "vyiW:<C-u>silent Browse <C-r>v<CR>
		vnoremap ZX "vy:silent Browse <C-r>v<CR>
	endif
endif
