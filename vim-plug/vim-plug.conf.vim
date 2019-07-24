scriptencoding utf-8

call plug#begin($VIMFILES.'/vim-plug')
	Plug 'vim-jp/autofmt'
	Plug 'vim-jp/vimdoc-ja'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'tyru/open-browser.vim'
	Plug 'tpope/vim-unimpaired'
	Plug 'mhinz/vim-janah'
	Plug 'previm/previm'

	if has('win32')
		Plug 'w0rp/ale'
		Plug 'LunarWatcher/vimsence'
	endif
call plug#end()

" vim-plugロード後の各プラグインの設定
" 多くなりそうなら個別conf.vimへ

" vimdoc-ja
set helplang=ja,en

" ale
if exists(':ALE') > 0
	let g:ale_sign_column_always = 1
endif
