scriptencoding utf-8

" 文字入力に関わるやつ
" キーマップが長いやつはsnipet.vimに書くように

" 一応明示的に書いておくやつ
set iminsert=0
set imsearch=-1

" IM操作用
augroup autoim
	autocmd!
	autocmd InsertLeave * set iminsert=0
augroup END

" インサートモード中の^hに対応して^lで<del>させる様に
inoremap <C-l> <del>

" <C-g>uが遠くて使いこなせない
inoremap <C-g><C-g> <C-g>u
inoremap <C-j> <CR><C-g>u

nnoremap <Leader>, i,<Esc>
nnoremap <Leader>. i.<Esc>
nnoremap <Leader><Space> i <Esc>
nnoremap <Leader><CR> i<CR><Esc>

" 改行周り
nnoremap <Leader>nr A  <Esc>
