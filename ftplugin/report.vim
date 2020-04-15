scriptencoding utf-8

runtime! ftplugin/markdown.vim

nnoremap <buffer> ]r :<C-u>call turnReport#main(1)<CR>
nnoremap <buffer> [r :<C-u>call turnReport#main(-1)<CR>
nnoremap <buffer> ]R :<C-u>call turnReport#main(1, '!')<CR>
nnoremap <buffer> [R :<C-u>call turnReport#main(-1, '!')<CR>
