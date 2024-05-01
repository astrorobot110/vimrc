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
cabbrev gas= call append('$', '// vim: set filetype=javascript ts=2 sts=2 sw=2 expandtab :')

if has('win32')
	" いいアイデアもろた
	cabbrev term= term pwsh
	cabbrev pwsh= set shell=pwsh\|shell\|set shell=C:\\WINDOWS\\system32\\cmd.exe
endif

if has('unix')
	" sudoめんどい
	cabbrev sudowrite= write !sudo tee % > /dev/null 2>&1
endif

" 必要な時だけ半角全角変換を読み込むやつ
cabbrev hz= source https://raw.githubusercontent.com/koron/vim-kaoriya/master/kaoriya/vim/plugins/kaoriya/plugin/hz_ja.vim
cabbrev HZ= sp +/Japanese\ Description: https://raw.githubusercontent.com/koron/vim-kaoriya/master/kaoriya/vim/plugins/kaoriya/plugin/hz_ja.vim

" フォント変更用
cabbrev <expr> font= 'set guifont='..escape(&guifont, ' \')

" privateから移転

for [ key, value ] in items(g:private)
	call execute(printf('cabbrev %s= %s', key, value))
endfor

