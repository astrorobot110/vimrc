scriptencoding utf-8

" 文字入力に関わるやつ
" キーマップが長いやつはsnipet.vimに書くように

" インサートモード中の^hに対応して^lで<del>させる様に
inoremap <C-l> <del>

" <C-g>uが遠くて使いこなせない
<<<<<<< HEAD
inoremap <C-g><C-u> <C-g>u
inoremap <C-m> <C-m><C-g>u
=======
inoremap <C-g><C-g> <C-g>u
inoremap <C-m> <CR><C-g>u
>>>>>>> fc4b0e0d8a28dcafd444589367bc930598dc94df

nnoremap <Leader>, i,<Esc>
nnoremap <Leader>. i.<Esc>
nnoremap <Leader>? i?<Esc>
nnoremap <Leader>! i!<Esc>
nnoremap <Leader><Space> i <Esc>
nnoremap <Leader><CR> i<CR><Esc>

" 改行周り
nnoremap <Leader>nr :<C-u>call setline('.', getline('.')..'  ')<CR>

" インサートモード中のZmenu的なやつ

" calcIt (コマンドモードなら<C-r>=あるので)
inoremap <expr> <C-z>= calcIt#main()

" ちょっと楽したい
inoremap <expr> <C-z>l '->'
