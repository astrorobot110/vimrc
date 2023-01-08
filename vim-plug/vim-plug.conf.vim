scriptencoding utf-8

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob(expand($VIMFILES.'/autoload/plug.vim')))
	cd $VIMFILES
	silent !curl -fLo autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	source $VIMFILES/autoload/plug.vim
endif

call plug#begin($VIMFILES.'/vim-plug')
	Plug 'vim-jp/autofmt'
	Plug 'vim-jp/vimdoc-ja'
	Plug 'tpope/vim-unimpaired'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'kana/vim-textobj-user'
	Plug 'kana/vim-textobj-function'
	Plug 'junegunn/vim-easy-align'
	" Plug 'tyru/open-browser.vim'
	Plug 'previm/previm'
	Plug 'tpope/vim-fugitive'
	" Plug 'vim-scripts/ScrollColors'
	" Plug 'ghifarit53/tokyonight-vim'
	Plug 'mhinz/vim-janah'
	" Plug 'othree/yajs.vim'

	if g:isWin
		Plug 'PProvost/vim-ps1'
	endif

	" 自分の
	" Plug 'astrorobot110/vialarm'
	" lug 'astrorobot110/technicolor'
call plug#end()

" vimdoc-ja
set helplang=ja,en
