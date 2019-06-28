scriptencoding utf-8

call plug#begin($VIMFILES.'/vim-plug')
	Plug 'vim-jp/autofmt'
	Plug 'vim-jp/vimdoc-ja'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'mhinz/vim-janah'
	Plug 'mattn/webapi-vim'
		\ | Plug 'mattn/vimplenote-vim'

	if has('win32')
		Plug 'w0rp/ale'
		Plug 'LunarWatcher/vimsence'
	endif

	" カラースキーム試したい時用
	" Plug 'flrnprz/taffy.vim'
	" Plug 'hzchirs/vim-material'
	" Plug 'danilo-augusto/vim-afterglow'
	" Plug 'w0ng/vim-hybrid'
	" Plug 'vim-scripts/wombat256.vim'
call plug#end()

" vim-plugロード後の各プラグインの設定
" 多くなりそうなら個別conf.vimへ

" vimdoc-ja
set helplang=ja,en

" 無理やりvimrcにカラースキームを書いたので失敗した時用
if execute('colorscheme') !=# g:colors_name
	call execute('colorscheme '.g:colors_name)
endif

if !g:isDroid
	" win固有
	if has('win32')
		" ale
		let g:ale_sign_column_always = 1
	endif

	" simplenote.vim
	" アカウント情報は別記
	if exists('SimplenoteList')
		let g:SimplenoteFiletype = 'markdown'
	endif
endif
