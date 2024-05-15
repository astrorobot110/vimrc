" Encoding settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,cp932,iso-2022-jp,euc-jisx0213,euc-jp

scriptencoding utf-8

" デバイス識別
if exists('$hostname')
	let g:device = $hostname
else
	let g:device = tolower(system('hostname')) ->trim()
endif

" OS毎の設定
if has('win32')
	set fileformat=dos
	set fileformats=dos,unix,mac
	set termguicolors

	" そろそろ行ける？
	set shell=pwsh
elseif has('unix')
	try
		language ja_JP.utf8
	catch /E197/
	endtry
	set fileformat=unix
	set fileformats=unix,dos,mac
endif

" 編集関係
set autoindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mMj
set formatoptions-=q
set textwidth=0

" なんで？
set modeline

" 画面表示
set tabstop=4
set shiftwidth=0
set virtualedit=onemore
set number
set ruler
set list
set listchars=tab:>-,trail:-
set wrap
set showcmd
set title
set cursorline
set equalalways
set scrolloff=8
set ambiwidth=double
set emoji
set display+=lastline

" これだけvimrcじゃないとダメとのことで
set guioptions+=M

" 結局入れといたほうがよかったので
set t_Co=256

" 検索周り
set ignorecase smartcase
set incsearch
set hlsearch

set diffopt=filler

" なんかデフォルト値かわった？
filetype plugin indent on
syntax on

" カラースキーム関係
" タイミング調整の為にオートコマンドに（わざわざautocmd.vimに書かんよ）

if g:device != 'aquos'
	set background=dark
	autocmd VimEnter * ++once ++nested colorscheme base16-decaf
else
	set background=light
	autocmd VimEnter * ++once ++nested colorscheme base16-ia-light
endif


" ステータスライン関係
" 表示用

function! Stl_showMode() abort
	return printf("mode: %s", mode())
endfunction

" デフォルト -> set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%4(%n%):\ %<%f\ [%{&fenc.'/'.&ff}]%h%w%m%r%=\ %l,%-8.(%c%V%)%{%Stl_showMode()%}\ [%4(%P%)]\ 
set laststatus=2

" ディレクトリ関係

" 汎用アドレス系は.privateディレクトリに行きました。

" やっぱ~/vimfiles対策要るわ

if v:version >= 900
	let $vimrc = expand('<script>:p:h')
else
	let $vimrc = expand('<sfile>:p:h')
endif

try
	source $vimrc/.private/localDirectory.vim
catch /E484/
endtry

set backup
let &backupdir = g:private.doc..'/backup'

set undofile
set undodir=$vimrc/.undo

set viewdir=$vimrc/.view
set viewoptions=folds,cursor,curdir

" viminfo
set viminfo+=n$vimrc/viminfo

" リマップ分割によりマップリーダーのトラブル頻発中
let g:mapleader = "\<space>"

" IM関係
set iminsert=0
set imsearch=-1

" 日本語の文章構造に対応するやつ
set matchpairs+=（:）,〔:〕,［:］,｛:｝,〈:〉,《:》,「:」,『:』,【:】,＜:＞

" netrwPlugin.vim用
let g:netrw_liststyle = 1
let g:netrw_mousemaps = 0
