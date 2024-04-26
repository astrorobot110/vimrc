scriptencoding utf-8

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

if has('win32')
	packadd vim-ps1
endif

if executable('w3m')
	packadd w3m.vim
endif

if expand('$vimrc/.private/textra_setup.vim')->filereadable()
	packadd textra.vim
	source $vimrc/.private/textra_setup.vim
endif
