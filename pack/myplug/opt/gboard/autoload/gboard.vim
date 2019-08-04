scriptencoding utf-8

function gboard#map(IFSize) abort
	for l in keys(extend(copy(g:longTap), {'<C-^>': ['<C-^>', '<C-^>']}))
		execute 'noremap <C-^>'.l g:longTap[l][a:IFSize]
		execute 'onoremap a<C-^>'.l 'a'.g:longTap[l][a:IFSize]
		execute 'onoremap i<C-^>'.l 'i'.g:longTap[l][a:IFSize]
	endfor
endfunction

function gboard#unmap() abort
	for l in keys(extend(copy(g:longTap), {'<C-^>': ['<C-^>', '<C-^>']}))
		try
			execute 'unmap <C-^>'.l
			execute 'ounmap a<C-^>'.l
			execute 'ounmap i<C-^>'.l
		catch /E31/
			continue
		endtry
	endfor
endfunction

function gboard#main(isBang,...) abort
	if a:isBang !=? '!'
		if a:0 > 0 && a:1 =~? '^\(large\|small\)$'
			if a:1 ==? 'large'
				let IFSize = 1
			else
				let IFSize = 0
			endif

			call gboard#map(IFSize)
			if v:vim_did_enter
				echo printf('[gboard]: Mapped for %s display.', tolower(a:1))
			endif
		else
			echo '[gboard]: Maps from gboard.vim'
			nmap <C-^>
		endif
	else
		call gboard#unmap()
		echo '[gboard]: Unmapped.'
	endif
endfunction
