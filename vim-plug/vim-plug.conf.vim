scriptencoding utf-8

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob(expand($VIMFILES.'/autoload/plug.vim')))
	cd $VIMFILES
	silent !curl -fLo autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	source $VIMFILES/autoload/plug.vim
endif

" 個別設定は`plug#begin()`前に

" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 0
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'}
" let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'}

" vimdoc-ja
set helplang=ja,en

" W3m.vim
if has('win32')
"	let g:w3m#command = 'C:\Cygwin64\bin\w3m.exe'
	let g:w3m#external_browser = 'C:\Program Files\Mozilla Firefox\firefox.exe'
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
	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-janah'
	Plug 'previm/previm'
	Plug 'tyru/open-browser.vim'
	" Plug 'prabirshrestha/vim-lsp'
	" Plug 'mattn/vim-lsp-settings'
	" Plug 'prabirshrestha/asyncomplete.vim'
	" Plug 'prabirshrestha/asyncomplete-lsp.vim'
	" Plug 'vim-scripts/ScrollColors'
	" Plug 'pangloss/vim-javascript'

	" ここから環境依存系

	if has('win32')
		Plug 'PProvost/vim-ps1'

		if executable(expand('~/AppData/Local/Discord/Update.exe'))
			Plug 'Stoozy/vimcord'
		endif
	endif

	if executable('w3m')
		Plug 'yuratomo/w3m.vim'
	endif

	" Previmの追加ライブラリ

let g:previm_extra_libraries = [
\  {
\    'name': 'foobar',
\    'files': [
\      {
\        'type': 'js',
\        'path': '_/js/extra/foobar.js',
\        'url': 'https://cdn.jsdelivr.net/gh/foobar/cdn-release@latest/build/foobar.min.js',
\        'code': ['foobar.init();'],
\      },
\      {
\        'type': 'css',
\        'path': '_/css/extra/foobar.css',
\        'url': 'https://cdn.jsdelivr.net/gh/foobar/cdn-release@latest/build/styles/default.min.css',
\      },
\    ],
\  },
\]

	" 自分の
	" Plug 'astrorobot110/vialarm'
	" Plug 'astrorobot110/technicolor'
call plug#end()
