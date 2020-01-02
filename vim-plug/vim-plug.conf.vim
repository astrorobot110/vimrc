scriptencoding utf-8

call plug#begin($VIMFILES.'/vim-plug')
	Plug 'vim-jp/autofmt'
	Plug 'vim-jp/vimdoc-ja'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'tpope/vim-unimpaired'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'tyru/open-browser.vim'
	Plug 'previm/previm'
	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-janah'
	Plug 'haishanh/night-owl.vim'

	if has('patch-8.2.1')
		Plug 'vim/killersheep'
	endif

	if has('win32')
		Plug 'LunarWatcher/vimsence'
	endif

	if $VIMDEVICE =~? '_unix$'
		Plug 'yuratomo/w3m.vim'
	endif
call plug#end()

" vim-plugロード後の各プラグインの設定
" 多くなりそうなら個別conf.vimへ

" vimdoc-ja
set helplang=ja,en

" previm
let g:previm_enable_realtime = 1

" w3m.vim
if exists(':W3m')
	let g:w3m#homepage = 'https://google.com'
	let g:w3m#search_engine = 'https://www.google.com/search?q='
endif
