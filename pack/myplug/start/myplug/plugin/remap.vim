scriptencoding utf-8

" 試しにリーダーキーを変えてみる
let g:mapleader = "\<space>"

" 甘えるな、hjklを使え
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <nop>

inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Right> <nop>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" DroidVimはカーソルなし無理！
if g:isDroid
	set mouse=a
	noremap <leftmouse> <nop>
	noremap! <leftmouse> <nop>
	noremap <up> <up>
	noremap <down> <down>
endif

" 赤鼻対策
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>

" ハイライト消し
noremap <ESC><ESC> :<C-u>noh<CR>

" :term のバインドひどくね？
if has('patch-8.0.1108')
	tnoremap <ESC> <C-w>n
endif

" バッファ辿る用
noremap <Leader>HH :br<CR>
noremap <Leader>hh :bp<CR>
noremap <Leader>ll :bn<CR>
noremap <Leader>LL :bl<CR>

" args辿る用
noremap <Leader>PP :first<CR>
noremap <Leader>pp :prev<CR>
noremap <Leader>nn :next<CR>
noremap <Leader>NN :last<CR>

"アンドゥ便利だと言ってもどうしてもshiftが押せない
nnoremap g= g+

" markdownをよく使うようになったので
noremap <Leader>md :<C-u>set ft=markdown<CR>

" 移動関係
noremap <Leader>ee :<C-u>e %:h<CR>
noremap <Leader>EE :<C-u>e! %:h<CR>

" 設定群への移動専用
nnoremap <Leader>v :<C-u>e v
nnoremap <Leader>V :<C-u>e! v

" 関数リストよく見るので
nnoremap <Leader>ff :<C-u>vert bo help function-list<CR>
nnoremap <Leader>FF :<C-u>bel help function-list<CR>

" エクスプローラーを開く用
if has('win32')
	noremap <silent> <Leader>xx :<C-u>silent !explorer "%:h"<CR>
endif

" ローカルプラグイン用

" Bangin
nnoremap <expr> <Leader>: Bbang()
nnoremap <expr> <Leader>~ Bslam()
nnoremap <expr> <Leader>' Bpang()
nnoremap <expr> <Leader>! Bflip()

" DeStain
nmap <Leader><S-Space> <Plug>(deStain)

" closer
imap <C-b> <Plug>(closer_main)
nnoremap <silent> <Leader>bb :<C-u>Closer!<CR>
nnoremap <silent> <Leader>BB :<C-u>Closer<CR>

" Zから始まるメニュー諸々
" 使いそうで使わないちょっと使うプラグインコマンドなどに

nnoremap Zp :<C-u>PlugInstall<CR>
nnoremap Zs :<C-u>source %<CR>
nnoremap Zc :Chords<CR>
vnoremap Zc :Chords<CR>
nnoremap ZC :<C-u>3,$Chords<CR>
nnoremap Zd :lcd %:p:h<CR>
nnoremap ZD :cd %:p:h<CR>

" droidvimオミット用

if !g:isDroid
	nnoremap Zn :<C-u>SimplenoteList<CR>
	nnoremap Zx :<C-u>silent Browse<CR>
	nnoremap ZX "vyiW:<C-u>silent Browse <C-r>v<CR>
	vnoremap ZX "vy:silent Browse <C-r>v<CR>
endif

" 文字入力に関わるやつ
" キーマップが長いやつはsnipet.vimに書くように

" 一応明示的に書いておくやつ
set iminsert=0
set imsearch=-1

" IM操作用
augroup autoim
	autocmd!
	autocmd InsertLeave * set iminsert=0
augroup END

" インサートモード中の^hに対応して^lで<del>させる様に
inoremap <C-l> <del>

" <C-g>uが遠くて使いこなせない
inoremap <C-g><C-g> <C-g>u
inoremap <C-j> <CR><C-g>u

nnoremap <Leader>, i,<Esc>
nnoremap <Leader>. i.<Esc>
nnoremap <Leader><Space> i <Esc>
nnoremap <Leader><CR> i<CR><Esc>

" 改行周り
nnoremap <Leader>nr A  <Esc>

" スニペット（短縮入力含む）

" 短縮入力に便利なやつ (マニュアルより）
" <C-R>=Eatchar('\s')<CR>を最後に足して使う
function! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunction

" インサートモードでの短縮入力

inoremap <expr> <C-]>charm '/.*^$]~\'
inoremap <expr> <C-]>regurl 'https\?:\/\/[0-9A-Za-z_\/:%#\$&?()\~\.=+-]\+'

" コマンドモードでの短縮入力
cabbrev H vert bo h
cabbrev readhelp help \| on<left><left><left><left><left>

" 手抜き用
cabbrev cd= %:p:h
cabbrev put= new +setlocal\ bt=nofile\|put=
cabbrev putexec= new +setlocal\ bt=nofile\|put=execute('')<left><left>

" アドレス用
" vimの設定群

cabbrev vv= $VIMFILES
cabbrev vV= $VIMFILES/vimrc
cabbrev vs= $VIMFILES/pack/myplug/start
cabbrev vS= $VIMFILES/pack/myplug
cabbrev vp= $VIMFILES/vim-plug
cabbrev vP= $VIMFILES/vim-plug/vim-plug.conf.vim

" samba

cabbrev lorenzo= scp://sasa@lorenzo//home/sasa
cabbrev cecilia= scp://root@cecilia//storage

" 汎用アドレス
if has('win32')
	cabbrev doc= ~/Documents
	cabbrev hymn= ~/Documents/pdf/hymnala
	cabbrev chtw= ~/cloud/gdrive/christ/twitter
	cabbrev some= ~/Documents/sometext
	cabbrev python= ~/Share/python
endif
