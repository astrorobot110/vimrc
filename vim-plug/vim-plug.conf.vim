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
	Plug 'vim-jp/vital.vim'
	Plug 'tpope/vim-unimpaired'
	Plug 'deton/jasegment.vim'
	Plug 'deton/jasentence.vim'
	Plug 'kana/vim-textobj-user'
	Plug 'kana/vim-textobj-function'
	Plug 'tyru/open-browser.vim'
	Plug 'previm/previm'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-scripts/ScrollColors'
	Plug 'flazz/vim-colorschemes'
	Plug 'ghifarit53/tokyonight-vim'

	if !( g:isDroid || g:isTermux )
		Plug 'mattn/vim-molder'
		Plug 'mattn/vim-molder-operations'
		Plug 'prabirshrestha/async.vim'
		Plug 'prabirshrestha/asyncomplete.vim'
		Plug 'prabirshrestha/asyncomplete-lsp.vim'
		Plug 'prabirshrestha/vim-lsp'
		Plug 'mattn/vim-lsp-settings'
	endif

	if has('patch-8.2.1')
		Plug 'tyru/empty-prompt.vim'
		Plug 'vim/killersheep'
	endif

	if g:isWin
		Plug 'hugolgst/vimsence'
		Plug 'PProvost/vim-ps1'
	endif

	if g:isUnix || g:isTermux
		Plug 'yuratomo/w3m.vim'
	endif

	" 自分の
	Plug 'astrorobot110/vialarm'
	Plug 'astrorobot110/technicolor'
call plug#end()

" vim-plugロード後の各プラグインの設定
" 多くなりそうなら個別conf.vimへ

" vimdoc-ja
set helplang=ja,en

" previm
let g:previm_enable_realtime = 1

" vim-lsp.vim
let g:lsp_diagnostics_echo_cursor = 1

" empty-prompt.vim
if exists('g:empty_prompt#pattern')
	let g:empty_prompt#pattern = &shell =~# 'sh$' ? '[\$#] $' : '>\s*$'
	function! s:empty_prompt_mappings() abort
		" If current line is empty prompt ...

		" : works as <C-w>:
		call empty_prompt#map(#{lhs: ':', rhs: '<C-w>:'})
		" <Esc> works as <C-w>N
		call empty_prompt#map(#{lhs: '<Esc>', rhs: '<C-w>N'})

		" ... Add more mappings you like
	endfunction

	autocmd VimEnter * ++once call s:empty_prompt_mappings()
endif

let g:molder_show_hidden = 1

" w3m.vim
if exists(':W3m')
	let g:w3m#homepage = 'https://google.com'
	let g:w3m#search_engine = 'https://www.google.com/search?q='
endif
