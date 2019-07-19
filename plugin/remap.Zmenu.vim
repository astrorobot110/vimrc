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
nnoremap Zd :lcd %:h<CR>
nnoremap ZD :cd %:h<CR>
nnoremap Zf :<C-u>vert bo help function-list<CR>
nnoremap ZF :<C-u>bel help function-list<CR>
nnoremap Zm :e <C-r>=g:memoPath<CR><CR>

" ここからpacker経由ロードプラグインのマップ

if exists(':OpenReading') == 2
	nnoremap Zr :<C-u>OpenReading
	nnoremap ZR :<C-u>OpenReading!
endif
