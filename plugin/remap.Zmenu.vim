scriptencoding utf-8

" Zから始まるメニュー諸々
" 使いそうで使わないちょっと使うプラグインコマンドなどに

nnoremap Zp :<C-u>PlugInstall<CR>
nnoremap Zs :<C-u>source %<CR>
nnoremap Zc :Chords<CR>
vnoremap Zc :Chords<CR>
nnoremap ZC :<C-u>3,$Chords<CR>
nnoremap Zd :lcd %:p:h<CR>
nnoremap ZD :cd %:p:h<CR>
nnoremap Zf :<C-u>vert bo help function-list<CR>
nnoremap ZF :<C-u>bel help function-list<CR>
