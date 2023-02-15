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
	Plug 'previm/previm'
	Plug 'tpope/vim-fugitive'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'mhinz/vim-janah'
	Plug 'yuratomo/w3m.vim'
	" Plug 'tyru/open-browser.vim'
	" Plug 'vim-scripts/ScrollColors'
	" Plug 'pangloss/vim-javascript'

	if has('win32')
		Plug 'PProvost/vim-ps1'
	endif

	" 自分の
	" Plug 'astrorobot110/vialarm'
	" Plug 'astrorobot110/technicolor'
call plug#end()

" vimdoc-ja
set helplang=ja,en

" W3m.vim
if has('win32')
	let g:w3m#command = 'C:\Cygwin64\bin\w3m.exe'
	let w3m#external_browser = 'C:\Program Files\Mozilla Firefox\firefox.exe'
endif
