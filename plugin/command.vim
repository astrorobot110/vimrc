scriptencoding utf-8

if !v:vim_did_enter
	call customCS#loader(g:colors_name)
endif

" bibleUrl
command! -nargs=* -bang Burl call bibleUrl#url('<bang>', <f-args>)

" chordSplitter
command! -range Chords :<line1>,<line2>call chordSplitter#main()

" closer
command! -bang Closer call closer#fromNormal('<bang>')
inoremap <expr> <Plug>(closer_main) closer#main()

" customCS
augroup customColor
	autocmd!
	autocmd ColorScheme * call customCS#loader(g:colors_name)
augroup END

" deStain
command! DeStain call deStain#main()
nnoremap <Plug>(deStain) :DeStain<CR>

" dumbQuit
if has('clientserver') && v:servername =~? 'GVIM\d*$' && has('patch-8.0.1595')
	augroup dumbQuit
		autocmd!
		au ExitPre * call dumbQuit#main()
	augroup END
endif

"getHighlight
command -nargs=1 -bang -complete=highlight GetHl call getHighlight#main(<q-args>, '<bang>')

" vimtutor
command! -nargs=? Tutorial call vimtutor#main(<f-args>)
