let $VIMFILES = split(&runtimepath, ',')[0]

let g:isDroid = $VIMFILES =~? 'droidvim'

if !g:isDroid
	if has('win32')
		let $VIMDEVICE = tolower($COMPUTERNAME).'_windows'
	elseif has('unix')
		let $VIMDEVICE = tolower(systemlist('hostname')[0]).'_unix'
	endif
endif

if $VIMDEVICE =~? '_unix$'
	language ja_JP.utf8
endif

" Encoding settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,cp932,iso-2022-jp,euc-jisx0213,euc-jp

scriptencoding utf-8

" why modeline dead?
set modeline

" シェル設定
" powershell移行は無理でした。

if has('win32')
	set shell=pwsh
	set shellcmdflag=-Command
	set shellquote=\"
	set shellxquote=
endif

if has('win32')
	set fileformat=dos
	set fileformats=dos,unix,mac
elseif has('unix')
	set fileformat=unix
	set fileformats=unix,dos,mac
endif

" 起動時だけ読むやつ
if !v:vim_did_enter
" 認証情報
	try
		source $VIMFILES/.private.vim
	catch /E484/
	endtry

" pack以下のプラグイン
	call packer#main()

" vim-plug
	source $VIMFILES/vim-plug/vim-plug.conf.vim

" リトライ処理
	if exists('g:retry')
		for r in g:retry
			execute 'source' r
		endfor

		unlet g:retry
	endif
endif

" 検索周り
set ignorecase smartcase
set incsearch
set hlsearch

set diffopt=filler

if !g:isDroid
	set diffopt+=vertical
endif

if has('win32')
	if has('patch-8.1.360')
		set diffopt+=internal
	else
		set diffexpr=mydiff#main()
	endif
endif

" 編集関係
set autoindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mMj

" 画面表示
set tabstop=4
set shiftwidth=4
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
set display+=lastline
set background=dark

" PowerShell上の問題
set t_Co=256
colorscheme janah

" ステータスライン関係
" デフォルト -> set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%4(%n%):\ %<%f\ [%{&fenc.'/'.&ff}]%h%w%m%r%=\ %l,%-7.(%c%V%)\ [%4(%P%)]\ 

" android用調整
set laststatus=2
let &cmdheight = g:isDroid ? 1 : 2

" ディレクトリ関係
if g:isDroid
	set backupdir=$INTERNAL_STORAGE/Documents/backup
else
	set backupdir=~/Documents/backup
endif

set backup

set undodir=$VIMFILES/.autogen//
set undofile

set viewdir=$VIMFILES/view

" viminfo
if !g:isDroid
	set viminfo+=n$VIMFILES/viminfo
else
	set viminfo+=n$HOME/.viminfo
endif

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
	let g:imctrl_normal = 53
	let g:imactivate_language_switch = 61
endif

" netrwPlugin.vim用
let g:netrw_liststyle = 1
let g:netrw_mousemaps = 0
" open-browserに任せるので…
let g:netrw_nogx = 1
