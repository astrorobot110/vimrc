scriptencoding utf-8

" ローカルプラグイン

" Bangin
nnoremap <expr> <Leader>: bangin#bang()

" DeStain
nmap <Leader><S-Space> <Plug>(deStain)

" closer
imap <C-b> <Plug>(closer_main)
nnoremap <silent> <Leader>bb :<C-u>Closer!<CR>
nnoremap <silent> <Leader>BB :<C-u>Closer<CR>

" vim-plugのプラグイン
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
