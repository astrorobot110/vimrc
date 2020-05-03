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
cabbrev sudowrite= w !sudo tee % > /dev/null 2>&1

" privateから移転
for [ key, value ] in items(g:private)
	if isdirectory(expand(value)) || filereadable(expand(value))
		call execute(printf('cabbrev %s= %s', key, value))
	endif
endfor

if has_key(g:private, 'memo')
	call execute('cabbrev Memo= vimgrep / '..g:private.memo..'/**/*.md<S-Left><S-Left>')
endif

if has_key(g:private, 'kim')
	call execute('cabbrev Kim= vimgrep / '..g:private.kim..'/*.md<S-Left><S-Left>')
endif

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
