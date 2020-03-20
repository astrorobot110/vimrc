scriptencoding utf-8

" chordSplitter
command! -range Chords :<line1>,<line2>call chordSplitter#main()

" closer
command! -bang Closer call closer#fromNormal('<bang>')
inoremap <expr> <Plug>(closer_main) closer#main()

" deStain
command! DeStain call deStain#main()
nnoremap <Plug>(deStain) :DeStain<CR>

" dumbQuit
if has('patch-8.0.1595') && ( !has('clientserver') || v:servername =~? 'VIM\d*$' )
	augroup dumbQuit
		autocmd!
		au ExitPre * call dumbQuit#main()
	augroup END
endif

"getHighlight
command -nargs=1 -bang -complete=highlight GetHl call getHighlight#main(<q-args>, '<bang>')

" vimtutor
command! -nargs=? Tutorial call vimtutor#main(<f-args>)
"
" calcIt
command! -nargs=0 Calc call calcIt#main()

" jig
command! -nargs=+ -bang GetStep call jig#step(<f-args>, '<bang>')
command! -nargs=+ -bang ToPolar call jig#polar(<f-args>, '<bang>')
