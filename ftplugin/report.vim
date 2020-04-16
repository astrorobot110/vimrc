scriptencoding utf-8

nnoremap <buffer> ]r :call turnReport#main(1)<CR>
nnoremap <buffer> [r :call turnReport#main(-1)<CR>
nnoremap <buffer> ]R :call turnReport#main(1, '!')<CR>
nnoremap <buffer> [R :call turnReport#main(-1, '!')<CR>

setlocal filetype=markdown
