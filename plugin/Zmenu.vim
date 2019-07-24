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

" ディレクトリ依存
if isdirectory(expand(g:memoPath))
	nnoremap Zm :<C-u>execute 'edit' g:memoPath<CR>
	nnoremap ZM :<C-u>bo vnew +put!\ =glob(g:memoPath.'/**/*.md')<CR>
endif

" packer経由ロードプラグインのマップ
if exists(':OpenReading') == 2
	nnoremap Zr :<C-u>OpenReading
	nnoremap ZR :<C-u>OpenReading!
endif

" plug.vimのプラグイン
if exists('*openbrowser#open')
	nnoremap Zx :<C-u>call openbrowser#open(expand('%:p'))<CR>
endif
