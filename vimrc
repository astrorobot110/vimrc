" Encoding settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,cp932,iso-2022-jp,euc-jisx0213,euc-jp

scriptencoding utf-8

let $VIMFILES = expand('<sfile>:p:h')

let g:isDroid = expand('~') =~? 'droidvim'
let g:isTermux = expand('~') =~? 'termux'
let g:isWin = has('win32') || has('win64')
let g:isUnix = has('unix') && !( g:isDroid || g:isTermux )

if g:isUnix
	language ja_JP.utf8
endif

if g:isWin
	set fileformat=dos
	set fileformats=dos,unix,mac
else
	set fileformat=unix
	set fileformats=unix,dos,mac
endif

" 起動時だけ読むやつ
if !v:vim_did_enter
" 認証情報
	try
		source $VIMFILES/.private.vim
	catch /E484/
		echo '".private.vim" not found.'
		let g:device = ''
	endtry

" pack以下のプラグイン
	call packer#main()

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

if g:isWin
	set termguicolors
endif

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

if has('win32')
  set shell=pwsh
  set shellcmdflag=-c
  set shellquote=\"
  set shellxquote=
endif

" PowerShell上の問題
set t_Co=256

" タイミング調整の為にオートコマンドに
autocmd VimEnter * ++once ++nested colorscheme wombat256mod

" ステータスライン関係
" デフォルト -> set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%4(%n%):\ %<%f\ [%{&fenc.'/'.&ff}]%h%w%m%r%=\ %l,%-7.(%c%V%)\ [%4(%P%)]\ 

" android用調整
set laststatus=2
let &cmdheight = g:isDroid || g:isTermux ? 1 : 2

" ディレクトリ関係
set backupdir=$DOCS/backup

set backup

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

augroup autoIM
	autocmd!
	autocmd InsertLeave * set iminsert=0
	autocmd CmdlineLeave * set iminsert=0
augroup END

" 日本語の文章構造に対応するやつ
set matchpairs+=（:）,〔:〕,［:］,｛:｝,〈:〉,《:》,「:」,『:』,【:】,＜:＞

" 脱初心者を目指すVimmerにオススメしたいVimプラグインや.vimrcの設定
" https://qiita.com/jnchito/items/5141b3b01bced9f7f48f#最後のカーソル位置を復元する
augroup lastCursor
	autocmd!
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\	 exe "normal! g'\"" |
	\ endif
augroup END

" droidVim専用
if g:isDroid
	" cuiのvimだけど…というやつ
	set mouse=n mousemodel=extend

	let g:imctrl_normal = 53
	let g:imactivate_language_switch = 61
endif

" netrwPlugin.vim用
let g:netrw_liststyle = 1
let g:netrw_mousemaps = 0
" open-browserに任せるので…
let g:netrw_nogx = 1
