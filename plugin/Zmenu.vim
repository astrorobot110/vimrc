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
" Relative line number
nnoremap Zl :<C-u>call deltaLine#main()<CR>
vnoremap Zl <Esc>:<C-u>call deltaLine#main()<CR>gv
" PlugInstall
nnoremap Zp :<C-u>PlugUpdate<CR>
nnoremap ZP :<C-u>PlugInstall<CR>
" Wrapper
nnoremap Zw :<C-u>setlocal wrap!<CR>
" CalcIt
nnoremap Z= :<C-u>Calc<CR>

" ディレクトリ依存
if isdirectory(fnameescape(get(g:private, 'memo', '/dev/null')))
	nnoremap Zm :<C-u>execute 'edit' g:private.memo<CR>
	nnoremap Z<C-m> :<C-u>edit $VIMFILE/.memo.ls \| put =escape(glob(g:private.memo..'/**/*.md'),' ')<CR>
endif

" cd to home
if exists('$INTERNAL_STORAGE')
	nnoremap Z/ :<C-u>cd $INTERNAL_STORAGE<CR>
else
	nnoremap Z/ :<C-u>cd ~<CR>
endif

" plug.vimのプラグイン
" OpenBrowser
nnoremap Zx :<C-u>execute 'OpenBrowser' expand('%:p')<CR>
nnoremap ZX :<C-u>execute 'OpenBrowser' eval('@'.input('Register: '))<CR>
