scriptencoding utf-8


augroup customColor
	autocmd!
	autocmd ColorScheme * call customCS#loader(g:colors_name)
augroup END

if !v:vim_did_enter
	call customCS#loader(g:colors_name)
endif
