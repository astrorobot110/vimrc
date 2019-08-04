scriptencoding utf-8

function gboard#map(IFSize) abort
	let longTap = g:longTap
	let longTap['<C-^>'] = ['<C-^>', '<C-^>']

	for l in keys(longTap)
		execute 'noremap <C-^>'.l g:longTap[l][a:IFSize]
	endfor
endfunction

function gboard#unmap() abort
	let longTap = g:longTap
	let longTap['<C-^>'] = ['<C-^>', '<C-^>']

	for l in keys(longTap)
		try
			execute 'unmap <C-^>'.l
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
