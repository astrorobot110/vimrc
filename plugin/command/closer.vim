scriptencoding utf-8

command! -bang Closer call closer#fromNormal('<bang>')

inoremap <expr> <Plug>(closer_main) closer#main()
