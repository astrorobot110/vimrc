scriptencoding utf-8

" スニペット（短縮入力含む）

" 短縮入力に便利なやつ (マニュアルより）
" <C-R>=Eatchar('\s')<CR>を最後に足して使う
function! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~# a:pat) ? '' : c
endfunction

" たまーに使うやつ
cabbrev charm= '/.*^$]~\'
cabbrev regurl= 'https\?:\/\/[0-9A-Za-z_\/:%#\$&?()\~\.=+-]\+'
cabbrev hankana= [ｦ-ﾟ]
cabbrev gas= $put ='// vim: set filetype=javascript ts=2 sts=2 sw=2 expandtab :'<CR>
if isdirectory(g:private.doc..'/obsidian/daily/')
	cabbrev memo= edit <C-r>=printf('%s/obsidian/daily/%s.md', g:private.doc, strftime('%y%m%d'))<CR>
endif

" sudoめんどい
cabbrev sudowrite= write !sudo tee % > /dev/null 2>&1

" 必要な時だけ半角全角変換を読み込むやつ
cabbrev hz= source https://raw.githubusercontent.com/koron/vim-kaoriya/master/kaoriya/vim/plugins/kaoriya/plugin/hz_ja.vim
cabbrev HZ= sp +/Japanese\ Description: https://raw.githubusercontent.com/koron/vim-kaoriya/master/kaoriya/vim/plugins/kaoriya/plugin/hz_ja.vim

" privateから移転
for [ key, value ] in items(g:private)
	if isdirectory(expand(value)) || filereadable(expand(value))
		call execute(printf('cabbrev %s= %s', key, value))
	endif
endfor

cabbrev vv= $VIMFILES
cabbrev vV= $VIMFILES/vimrc
cabbrev vs= $VIMFILES/plugin
cabbrev vS= $VIMFILES/pack/myplug/opt
cabbrev va= $VIMFILES/autoload
cabbrev vA= $VIMFILES/plugin/command.vim
cabbrev vp= $VIMFILES/vim-plug
cabbrev vP= $VIMFILES/vim-plug/vim-plug.conf.vim
