scriptencoding utf-8

" ローカルプラグイン

" Bangin
nnoremap <expr> <Leader>: bangin#bang()
nnoremap <expr> <Leader>~ Bangin#slam()
nnoremap <expr> <Leader>' Bangin#pang()
nnoremap <expr> <Leader>! Bangin#flip()

" DeStain
nmap <Leader><S-Space> <Plug>(deStain)

" closer
imap <C-b> <Plug>(closer_main)
nnoremap <silent> <Leader>bb :<C-u>Closer!<CR>
nnoremap <silent> <Leader>BB :<C-u>Closer<CR>
