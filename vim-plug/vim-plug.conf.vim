scriptencoding utf-8

call plug#begin($VIMFILES.'/vim-plug')
	Plug 'vim-jp/autofmt'
	Plug 'vim-jp/vimdoc-ja'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'flazz/vim-colorschemes'
	Plug 'arzg/vim-wizard'

	if !g:isDroid
		if has('python3')
			Plug 'mrtazz/simplenote.vim'
		endif
	endif

	if has('win32')
		Plug 'w0rp/ale'
		Plug 'LunarWatcher/vimsence'
	endif
call plug#end()

" vim-plugロード後の各プラグインの設定
" 多くなりそうなら個別conf.vimへ

" vimdoc-ja
set helplang=ja,en

call execute('colorscheme '.g:colors_name)

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
