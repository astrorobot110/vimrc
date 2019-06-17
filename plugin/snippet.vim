scriptencoding utf-8

" スニペット（短縮入力含む）

" 短縮入力に便利なやつ (マニュアルより）
" <C-R>=Eatchar('\s')<CR>を最後に足して使う
function! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunction

" インサートモードでの短縮入力

inoremap <expr> <C-]>charm '/.*^$]~\'
inoremap <expr> <C-]>regurl 'https\?:\/\/[0-9A-Za-z_\/:%#\$&?()\~\.=+-]\+'

" コマンドモードでの短縮入力
cabbrev H vert bo h
cabbrev readhelp help \| on<left><left><left><left><left>

" 手抜き用
cabbrev cd= %:p:h
cabbrev put= new +setlocal\ bt=nofile\|put=
cabbrev putexec= new +setlocal\ bt=nofile\|put=execute('')<left><left>

" アドレス用
" vimの設定群

cabbrev vv= $VIMFILES
cabbrev vV= $VIMFILES/vimrc
cabbrev vs= $VIMFILES/plugin
cabbrev vS= $VIMFILES/pack/myplug/opt
cabbrev vp= $VIMFILES/vim-plug
cabbrev vP= $VIMFILES/vim-plug/vim-plug.conf.vim

" samba

cabbrev lorenzo= scp://sasa@lorenzo//home/sasa
cabbrev cecilia= scp://root@cecilia//storage

" 汎用アドレス
let s:pathDict = {
	\ 'hymn': '~/Documents/pdf/hymnala',
	\ 'chtw': '~/cloud/gdrive/christ/twitter',
	\ 'some': '~/Documents/sometext',
	\ 'python': '~/Share/python'
\ }

" ドキュメントフォルダだけややこしいのよね
let s:pathDict['doc'] = g:isDroid ? '$INTERNAL_STORAGE/Documents' : '~/Documents'

for c in keys(s:pathDict)
	if isdirectory(expand(s:pathDict[c]))
		call execute(printf('cabbrev %s= %s', c, s:pathDict[c]))
	endif
endfor
