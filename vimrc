" Encoding settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,cp932,iso-2022-jp,euc-jisx0213,euc-jp

scriptencoding utf-8

let $VIMFILES = expand('<sfile>:p:h')

let g:isWin = has('win32') || has('win64')
let g:isUnix = has('unix')

" デバイス識別
if g:isWin
	let g:device = tolower($COMPUTERNAME)
	set fileformat=dos
	set fileformats=dos,unix,mac
	set termguicolors
elseif g:isUnix
	let g:device = tolower(system('echo $(hostname)')) ->trim()
	language ja_JP.utf8
	set fileformat=unix
	set fileformats=unix,dos,mac
endif

" 起動時だけ読むやつ
if !v:vim_did_enter

" vim-plug
	source $VIMFILES/vim-plug/vim-plug.conf.vim
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
set background=dark

" これだけvimrcじゃないとダメとのことで
set guioptions+=M

" 検索周り
set ignorecase smartcase
set incsearch
set hlsearch

set diffopt=filler

if &columns < 80
	set diffopt+=vertical
endif

" タイミング調整の為にオートコマンドに
autocmd VimEnter * ++once ++nested colorscheme janah

" ステータスライン関係
" デフォルト -> set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%4(%n%):\ %<%f\ [%{&fenc.'/'.&ff}]%h%w%m%r%=\ %l,%-7.(%c%V%)\ [%4(%P%)]\ 

" ディレクトリ関係
"
" 汎用アドレス
let $DOCS = expand('~/Documents')

if isdirectory($DOCS..'/Documents')
	let $DOCS .= '/Documents'
endif

let g:private = { 'doc': $DOCS }
set backup
let &backupdir = expand(g:private.doc..'/backup')

set undodir=$VIMFILES/.autogen//
set undofile

set viewdir=$VIMFILES/view

" viminfo
set viminfo+=n$VIMFILES/viminfo

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
