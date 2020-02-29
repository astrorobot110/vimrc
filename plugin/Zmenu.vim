scriptencoding utf-8

" ZZ/ZQ潰ししなくても使っていけるんじゃ…？
" nmap Z <Nop>

" Zから始まるメニュー諸々
" 使いそうで使わないちょっと使うプラグインコマンドなどに

" Select all.
nnoremap Za ggVG
" Chordsplitter
nnoremap Zc :Chords<CR>
vnoremap Zc :Chords<CR>
nnoremap ZC :<C-u>3,$Chords<CR>
" cd to current buffer.
nnoremap Zd :lcd %:h<CR>
nnoremap ZD :cd %:h<CR>
" Quick help to function-list
nnoremap Zh :<C-u>vert bo help function-list<CR>
" PlugInstall
nnoremap Zp :<C-u>PlugUpdate<CR>
nnoremap ZP :<C-u>PlugInstall<CR>
" Wrapper
nnoremap Zw :<C-u>setlocal wrap!<CR>
" CalcIt
nnoremap Z= :<C-u>Calc<CR>
inoremap <expr> <C-z>= calcIt#main()
" Remove search register
nnoremap Z/ :let @/ = ''<CR>

" ディレクトリ依存
if isdirectory(expand('$DOCS/git/memo'))
	nnoremap Zm :<C-u>edit $DOCS/git/memo<CR>
	nnoremap ZM :<C-u>edit $VIMFILE/.memo.ls \| put =escape(glob(g:memoPath.'/**/*.md'),' ')<CR>
endif

" plug.vimのプラグイン
" fugitive
nnoremap Zg :<C-u>Gstatus<CR>
" OpenBrowser
nnoremap Zx :<C-u>execute 'OpenBrowser' expand('%:p')<CR>
nnoremap ZX :<C-u>execute 'OpenBrowser' eval('@'.input('Register: '))<CR>
