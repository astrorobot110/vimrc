scriptencoding utf-8

" ローカルプラグイン

" Bangin
nnoremap <expr> <Leader>: bangin#bang()
nnoremap <expr> <Leader>~ bangin#slam()
nnoremap <expr> <Leader>' bangin#pang()
nnoremap <expr> <Leader>! bangin#flip()

" DeStain
nmap <Leader><S-Space> <Plug>(deStain)

" closer
imap <C-b> <Plug>(closer_main)
nnoremap <silent> <Leader>bb :<C-u>Closer!<CR>
nnoremap <silent> <Leader>BB :<C-u>Closer<CR>
