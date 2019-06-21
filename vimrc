" vim:set ff=unix:

" Encoding settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,cp932,iso-2022-jp,euc-jisx0213,euc-jp

" シェル設定
if has('win32')
	set shell=pwsh
	set shellcmdflag=-c
	set shellquote=\"
	set shellxquote=
endif

let $VIMFILES = split(&runtimepath, ',')[0]

let g:isDroid = $VIMFILES =~? 'droidvim' ? v:true : v:false

if !g:isDroid
	if has('win32')
		let $VIMDEVICE = tolower($COMPUTERNAME).'_windows'
	elseif has('unix')
		let $VIMDEVICE = tolower(systemlist('hostname')[0]).'_unix'
	endif
endif

if has('win32')
	set fileformat=dos
	set fileformats=dos,unix,mac
elseif has('unix')
	set fileformat=unix
	set fileformats=unix,dos,mac
endif

scriptencoding utf-8

" 検索周り
set ignorecase smartcase
set hlsearch

" diff関連
if has('win32')
	function! MyDiff()
		let diffExec = $VIM.'\vim81\diff.exe'
		let opt = ''
		if &diffopt =~# 'icase'
			let opt = opt . ' -i'
		endif
		if &diffopt =~# 'iwhite'
			let opt = opt . ' -b'
		endif
		call writefile(systemlist(printf('%s -a --binary %s %s %s', diffExec, opt, v:fname_in, v:fname_new)), v:fname_out)
	endfunction

	set diffexpr=MyDiff()
endif

set diffopt=filler,vertical

" 編集関係
set autoindent
set backspace=indent,eol,start
set wildmenu
set clipboard^=unnamed
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

" PowerShell上の問題
set t_Co=256

" ステータスライン関係
" デフォルト -> set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%4(%n%):\ %<%f\ [%{&fenc.'/'.&ff}]%h%w%m%r%=\ %l,%-7.(%c%V%)\ [%4(%P%)]\ 
if $VIMDEVICE !~? '_mobile$'
	set laststatus=2
endif

" android用調整
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
if has('patch-8.0.716')
	if !g:isDroid
		set viminfofile=$VIMFILES/viminfo
	else
		set viminfofile=$HOME/.viminfo
	endif
else
	set viminfo+=n$VIMFILES/viminfo
endif

" 日本語の文章構造に対応するやつ
set matchpairs+=（:）,〔:〕,［:］,｛:｝,〈:〉,《:》,「:」,『:』,【:】,＜:＞

" 脱初心者を目指すVimmerにオススメしたいVimプラグインや.vimrcの設定
" https://qiita.com/jnchito/items/5141b3b01bced9f7f48f#最後のカーソル位置を復元する
if has('autocmd')
	augroup lastCursor
		autocmd!
		autocmd BufReadPost *
		\ if line("'\"") > 0 && line ("'\"") <= line("$") |
		\	 exe "normal! g'\"" |
		\ endif
	augroup END
endif

" 起動時だけ読むやつ
if !exists('g:isFirstLoad') || g:isFirstLoad
" netrwPlugin.vim用
	let g:netrw_liststyle = 1
	let g:netrw_mousemaps = 0

" 認証情報
	if filereadable($VIMFILES.'/.private.vim')
		source $VIMFILES/.private.vim
	endif

" vim-plug
	source $VIMFILES/vim-plug/vim-plug.conf.vim
	let g:isVimplugLoaded = 1

" リマップ分割によりマップリーダーのトラブル頻発中
	let g:mapleader = "\<space>"

" droidVim専用
	let g:imctrl_normal = 53

	let g:isFirstLoad = 0
endif
