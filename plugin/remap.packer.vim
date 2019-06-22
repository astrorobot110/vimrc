scriptencoding utf-8

call packer#main()

if exists(':OpenReading') == 2
	nnoremap Zr :<C-u>OpenReading
	nnoremap ZR :<C-u>OpenReading!
endif

if exists(':QiitaFiles') == 2
	nnoremap <Leader>qq :<C-u>QiitaFiles<CR>
endif

if exists(':Browse') == 2
	nnoremap Zx "byiW:<C-u>silent Browse <C-r>b<CR>
	nnoremap ZX :<C-u>silent Browse<CR>
	vnoremap Zx "by:silent Browse <C-r>b<CR>
endif
