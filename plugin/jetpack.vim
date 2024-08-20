scriptencoding utf-8

try
	packadd vim-jetpack
catch /^Vim\%((\a\+)\)\=:E919:/
	let jetpackFile = $vimrc..'/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
	let jetpackUrl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
	call printf('curl -fLo %s --create-dirs %s, jetpackFile, jetpackUrl)->system()
	packadd vim-jetpack
endtry

" vimdoc-ja
set helplang=ja,en

" W3m.vim
if has('win32')
"	let g:w3m#command = 'C:\Cygwin64\bin\w3m.exe'
	let g:w3m#external_browser = 'C:\Program Files\Mozilla Firefox\firefox.exe'
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

call jetpack#begin()
	Jetpack 'tani/vim-jetpack', { 'opt': 1 } "bootstrap

	Jetpack 'mhinz/vim-janah'
	Jetpack 'tpope/vim-fugitive'
	packadd vim-fugitive
	Jetpack 'vim-jp/vimdoc-ja'
	Jetpack 'vim-jp/autofmt'
	Jetpack 'tpope/vim-unimpaired'
	Jetpack 'deton/jasegment.vim'
	Jetpack 'deton/jasentence.vim'
	Jetpack 'kana/vim-textobj-user'
	Jetpack 'kana/vim-textobj-function'
	Jetpack 'junegunn/vim-easy-align'
	packadd vim-easy-align
	Jetpack 'morhetz/gruvbox.git'
	Jetpack 'jordwalke/VimCleanColors'
	Jetpack 'jsit/toast.vim'
"	Jetpack 'astrorobot110/vialarm'
"	Jetpack 'kawarimidoll/textra.vim'

	" On-demanded
	if has('gui')
		Jetpack 'previm/previm'
		packadd previm
		Jetpack 'tyru/open-browser.vim'
		packadd open-browser.vim
	endif

	if has('win32')
		Jetpack 'PProvost/vim-ps1'
		Jetpack 'Stoozy/vimcord'
	endif

	if executable('w3m')
		Jetpack 'yuratomo/w3m.vim'
		packadd w3m.vim
	endif

call jetpack#end()
