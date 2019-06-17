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
nnoremap Zx :<C-u>silent Browse<CR>
nnoremap ZX "vyiW:<C-u>silent Browse <C-r>v<CR>
vnoremap ZX "vy:silent Browse <C-r>v<CR>
