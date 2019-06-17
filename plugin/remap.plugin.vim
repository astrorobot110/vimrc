scriptencoding utf-8

" ローカルプラグイン用

" Bangin
nnoremap <expr> <Leader>: Bbang()
nnoremap <expr> <Leader>~ Bslam()
nnoremap <expr> <Leader>' Bpang()
nnoremap <expr> <Leader>! Bflip()

" DeStain
nmap <Leader><S-Space> <Plug>(deStain)

" closer
imap <C-b> <Plug>(closer_main)
nnoremap <silent> <Leader>bb :<C-u>Closer!<CR>
nnoremap <silent> <Leader>BB :<C-u>Closer<CR>
