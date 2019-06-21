scriptencoding utf-8

" ローカルプラグイン

" :Packer 関連は $VIMFILES/plugin/remap.pack.vim に

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
