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
nnoremap Zp :<C-u>PlugInstall<CR>
" CalcIt
nnoremap Z= :<C-u>Calc<CR>
inoremap <expr> <C-z>= calcIt#main()
" Remove search register
nnoremap Z/ :let @/ = ''<CR>

" ディレクトリ依存
if isdirectory(expand('$DOCS/git/memo'))
	let memoSplit = g:isDroid || g:isTermux ? 'edit' : 'bel vs'
	nnoremap Zm :<C-u>execute memoSplit '$DOCS/git/memo'<CR>
	nnoremap ZM :<C-u>bo vs $VIMFILE/.memo.ls \| put =escape(glob(g:memoPath.'/**/*.md'),' ')<CR>
endif

" plug.vimのプラグイン
" fugitive
nnoremap Zg :<C-u>Gstatus<CR>
nnoremap Zx :<C-u>execute 'OpenBrowser' expand('%:p')<CR>
nnoremap ZX :<C-u>execute 'OpenBrowser' eval('@'.input('Register: '))<CR>
