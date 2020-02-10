scriptencoding utf-8

" スニペット（短縮入力含む）

" 短縮入力に便利なやつ (マニュアルより）
" <C-R>=Eatchar('\s')<CR>を最後に足して使う
function! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunction

" たまーに使うやつ
cabbrev charm= '/.*^$]~\'
cabbrev regurl= 'https\?:\/\/[0-9A-Za-z_\/:%#\$&?()\~\.=+-]\+'

" sudoめんどい
cabbrev sudowrite w !sudo tee % > /dev/null 2>&1

" dailySaveしてくれない…
cabbrev dailysave= do User vialarm_17:00

" 設定群への移動専用
nnoremap <Leader>v :<C-u>e v
nnoremap <Leader>V :<C-u>cd v

cabbrev vv= $VIMFILES
cabbrev vV= $VIMFILES/vimrc
cabbrev vs= $VIMFILES/plugin
cabbrev vS= $VIMFILES/pack/myplug/opt
cabbrev va= $VIMFILES/autoload
cabbrev vA= $VIMFILES/plugin/command.vim
cabbrev vp= $VIMFILES/vim-plug
cabbrev vP= $VIMFILES/vim-plug/vim-plug.conf.vim

" その他よく使いたい設定群

cabbrev md= setlocal filetype=markdown
cabbrev <expr> pwd= expand('%:p:h')
cabbrev <expr> fname= expand('%:t')
cabbrev <expr> filename= expand('%:p')

" エクスプローラーを開く用
if has('win32')
	cabbrev explorer= silent !explorer
endif
