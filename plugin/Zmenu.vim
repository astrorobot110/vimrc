scriptencoding utf-8

" ZZ/ZQ潰ししなくても使っていけるんじゃ…？
" nmap Z <Nop>

" Zから始まるメニュー諸々
" 使いそうで使わないちょっと使うプラグインコマンドなどに

nnoremap Zp :<C-u>PlugInstall<CR>
nnoremap Zs :<C-u>source %<CR>
nnoremap Zc :Chords<CR>
vnoremap Zc :Chords<CR>
nnoremap ZC :<C-u>3,$Chords<CR>
nnoremap Zd :lcd %:h<CR>
nnoremap ZD :cd %:h<CR>
nnoremap Zh :<C-u>vert bo help function-list<CR>
nnoremap ZH :<C-u>bel help function-list<CR>
nnoremap Z= :<C-u>Calc<CR>

" ディレクトリ依存
if exists('g:memoPath') && isdirectory(expand(g:memoPath))
	let memoSplit = g:isDroid ? 'edit' : 'bel vs'
	nnoremap Zm :<C-u>execute memoSplit g:memoPath<CR>
	nnoremap ZM :<C-u>bo vs $VIMFILE/.memo.ls \| put =escape(glob(g:memoPath.'/**/*.md'),' ')<CR>
endif

" 変数依存
if exists(':DailySave')
	noremap Zw :<C-u>DailySave<CR>
endif

" plug.vimのプラグイン
nnoremap Zx :<C-u>execute 'OpenBrowser' expand('%:p')<CR>
nnoremap ZX :<C-u>execute 'OpenBrowser' eval('@'.input('Register: '))<CR>
