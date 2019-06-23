scriptencoding utf-8

" ZZ/ZQ潰し
nmap Z <Nop>

" とその補填
nnoremap <Leader>ZZ ZZ
nnoremap <Leader>ZQ ZQ

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

" ここからpacker経由ロードプラグインのマップ

if exists(':OpenReading') == 2
	nnoremap Zr :<C-u>OpenReading
	nnoremap ZR :<C-u>OpenReading!
endif

if exists(':Browse') == 2
	nnoremap Zx "byiW:<C-u>silent Browse <C-r>b<CR>
	nnoremap ZX :<C-u>silent Browse<CR>
	vnoremap Zx "by:silent Browse <C-r>b<CR>
endif

if exists(':QiitaFiles') == 2
	nnoremap Zq :<C-u>QiitaFiles<CR>
endif
