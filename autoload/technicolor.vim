scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpo&vim

" グローバル変数 {{{1
" RGB値でのグレーがctermパレットのグレースケール以外にあった場合用
let s:gray2color = {
		\ '95': 59,
		\ '135': 102,
		\ '175': 145,
		\ '215': 188
		\ }

" ctermパレットからRGB値への変換用
let s:rgbValue = ['00', '5f', '87', 'af', 'd7', 'ff']

" cterm/guiのインバーター (めんどかった)
let s:targetDict = {'cterm': 'gui', 'gui': 'cterm'}

" vimが解釈する色名のリスト
let s:colorName = [
		\ 'none', 'bg', 'BackGround', 'fg', 'ForeGround', 'Black',
		\ 'DarkRed', 'DarkGreen', 'DarkYellow', 'Brown', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray', 'Grey',
		\ 'DarkGray', 'DarkGrey', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
		\ 'LightGray', 'LightGrey', 'lightRed', 'LightGreen', 'LightYellow', 'LightBlue', 'LightMagenta', 'LightCyan'
		\ ]

" gVimのみ解釈する色名のcterm近似色
let s:name2cterm = {
		\ 'orange': 214,
		\ 'purple': 129,
		\ 'violet': 213,
		\ 'seagreen': 29,
		\ 'slateblue': 62
		\ }

" highlightコマンド記述の構造テンプレ
let s:technicolorTemplate = {
		\ 'order': ['ctermfg', 'ctermbg', 'cterm', 'guifg', 'guibg', 'gui'],
		\ 'orderLength': [16, 16, 16, 16, 16, 0],
		\ 'head': 'highlight',
		\ 'headLength': 24,
		\ 'isTab': 1,
		\ 'isUppercase': 0
		\ }

" ハイライトテンプレに関して {{{2

"	technicolorではハイライトの構造を確認するために…
"		1. 現在のカーソル位置から上に検索して、直近の空行の下にあるハイライトコマンドの構造
"		2. Normalグループの記述の構造
"		3. 辞書変数 `b:technicolorTemplate`による定義
"		4. 上記辞書変数 `s:technicolorTemplate`による定義
"	…の順に記述があるものを確認しています。
"	この場合、1.に該当するのにテンプレートとして機能しないケースが存在します。
"	そのために現在の行が参照してほしいテンプレートを…
"
"		> " technicolor		ctermfg=15		ctermbg=0		cterm=none		guifg=#FFFFFF		guibg=#000000	gui=none
"
"	…のように、行頭が `" technicolor` の行をハイライトコマンドの記述とみなして使用します。
"	`b:technicolorTemplate`は上記の `s:technicolorTemplate` の行をコピーして使うのが当座簡単かなとおもいます。
" }}}

"}}}

" s:gui2cterm(): guiからctermへ変換 (システムカラーへは変換しない) {{{1
function! s:gui2cterm(guiColor) abort
	if a:guiColor =~ '^#\?\x\{6}$'
		let rgbList = matchlist(a:guiColor, '\v^#(\x\x)(\x\x)(\x\x)')[1:3]
				\ ->map({_, val ->str2nr(val, 16)})

		if len(uniq(copy(rgbList))) == 1
			return s:gray2cterm(rgbList[0])
		endif

		return s:rgb2cterm(rgbList)
	elseif has_key(s:name2cterm, tolower(a:guiColor))
		return s:name2cterm[tolower(a:guiColor)]
	elseif match(s:colorName, '^'..a:guiColor..'$') > 0
		return a:guiColor
	else
		return 'none'
	endif
endfunction

" s:rgb2cterm(): RGB値からctermへ変換 {{{2
function! s:rgb2cterm(rgbList) abort
	for value in a:rgbList
		let ctermColor = get(l:, 'ctermColor', 0)*6
		if value >= 75
			let ctermColor += ((value-75)/40)+1
		endif
	endfor

	return ctermColor+16
endfunction
" }}}

" s:gray2cterm() RGB値がグレーになる場合 {{{2
function! s:gray2cterm(level) abort
	if a:level <= 3
		return 16
	elseif a:level >= 243
		return 231
	elseif has_key(s:gray2color, a:level)
		return s:gray2color[a:level]
	endif

	let step = sort([0, (a:level-3)/10, 23], 'n')[1]

	return step+232
endfunction
" }}}

" }}}

" s:cterm2gui(): ctermからguiへ変換 {{{1
function! s:cterm2gui(ctermColor) abort
	if a:ctermColor < 0 || a:ctermColor > 255
		return 'none'
	elseif a:ctermColor <= 15
		return s:term2sysRgb(a:ctermColor)
	elseif a:ctermColor >= 232
		return s:term2gray(a:ctermColor-232)
	elseif str2nr(a:ctermColor) > 0
		return s:term2rgb(a:ctermColor-16)
	elseif match(s:colorName, '^'..a:ctermColor..'$') > 0
		return a:ctermColor
	endif
	return 'none'
endfunction

" s:term2sysRgb(): xtermシステムカラーからRGB値へ変換 {{{2
function! s:term2sysRgb(termColor) abort
	if a:termColor == 7
		return '#c0c0c0'
	elseif a:termcolor == 8
		return '#808080'
	elseif a:termcolor < 7
		let value = '80'
	else
		let value = 'ff'
	endif

	let rgb = '#'

	for div in [1, 2, 4]
		let rgb .= (a:termColor/div)%2 == 0 ? '00' : value
	endfor

	if b:technicolor.isUppercase
		let rgb = toupper(rgb)
	endif

	return rgb
endfunction
" }}}

" s:term2gray(): xtermパレットのグレースケールからRGB値へ変換 {{{2
function! s:term2gray(termColor) abort
	let print = b:technicolor.isUppercase ? '%02X' : '%02x'
	let rgb = printf(print, a:termColor*10+8)
	return '#'..repeat(rgb, 3)
endfunction
" }}}

" s:term2rgb(): xtermカラーパレットからRGB値へ変換 {{{2
function! s:term2rgb(termColor) abort
	let rgb = '#'

	for div in [36, 6, 1]
		let rgb .= s:rgbValue[(a:termColor/div)%6]
	endfor

	if b:technicolor.isUppercase
		let rgb = toupper(rgb)
	endif

	return rgb
endfunction
" }}}

" }}}

" s:getStructure(): スクリプト内highlightの記述解析 {{{1
function! s:getStructure() abort
	let span = []
			\ ->add(search('^$', 'nb')+1)
			\ ->add(search('^$', 'n'))

	while match(getline(span[0]), '\v\c^(hi(ghlight)?\!?|"\s?technicolor)', '') < 0
		let span[0] += 1
		if span[0] > line('.')
			break
		endif
	endwhile

	if span[0] > line('.')
		let normalGroup = search('^hi\(ghlight\)\?!\?\s\cnormal', 'nw')
		if normalGroup <= 0
			let b:technicolor = deepcopy(get(b:, 'technicolorTemplate', s:technicolorTemplate))
			let b:technicolor.span = [ line('.'), line('.')+1 ]

			return
		else
			let line = split(getline(normalGroup), '\s\+\zs\ze\S\+=')
			let span = [ line('.'), line('.')+1 ]
		endif
	else
		let line = split(getline(span[0]), '\s\+\zs\ze\S\+=')
	endif

	let b:technicolor = get(b:, 'technicolor', {})

	let b:technicolor.span = span

	let b:technicolor.head = line[0][0] !=# '"' ?
			\ matchstr(line[0], '^\S\+', '') :
			\ matchstr(getline(b:technicolor.span[0]+1), '^\S\+', '')
		let b:technicolor.headLength = strdisplaywidth(line[0])

	let b:technicolor.isTab = matchstr(line[0], '\s$', '') ==# "\t"

	let b:technicolor.order = {}
	let b:technicolor.order = map(line[1:], {_, val->matchstr(val, '\S\+\ze=')})
	let b:technicolor.orderLength = map(line[1:-2], {_, val->strdisplaywidth(val)})
			\ ->add(0)

	let hexedParam = matchstr(line[match(b:technicolor.order, 'guifg')+1], '=#\zs\x\+', '')
	let b:technicolor.isUppercase = hexedParam =~# '\u'
endfunction
" }}}

" main {{{1
function! technicolor#main(args) abort
	if !exists('b:technicolor') || sort(b:technicolor.span + [line('.')], 'n')[1] != line('.')
		call s:getStructure()
	endif

	let [env, ground, value] = matchlist(a:args, '\v(cterm|gui)(fg|bg|)\=(.+)')[1:3]

	let target = s:targetDict[tolower(env)]

	if ground != ''
		let targetValue = funcref(printf('s:%s2%s', env, target))(value)
	else
		let targetValue = value
	endif

	let params = {}
	let [space, tabstop] = b:technicolor.isTab ?
			\ ["\t", &tabstop] :
			\ [' ', 1]

	for line in split(getline('.'), '\s\+\ze\S\+=')
		if match(line, '^hi\(ghlight\)\?') < 0
			let [ paramTarget, paramValue ] = split(line, '=')
			let params[paramTarget] = paramValue
		else
			let space = b:technicolor.isTab ?
					\ repeat("\t", (b:technicolor.headLength-len(line))/tabstop+1) :
					\ repeat(' ', b:technicolor.headLength-len(line))
			let output = line .. space
		endif
	endfor

	let params[env..ground] = value
	let params[target..ground] = targetValue

	echo params

	let index = 0

	while index < len(b:technicolor.order)
		let space = b:technicolor.orderLength[index] > 0 ? "\t" : ''

		if exists('params[b:technicolor.order['..index..']]')
			let toOut = printf('%s=%s', b:technicolor.order[index], params[b:technicolor.order[index]])
		else
			let toOut = repeat(space, b:technicolor.orderLength[index]/tabstop)
		endif

		while strdisplaywidth(toOut) < b:technicolor.orderLength[index]
			let toOut .= space
		endwhile

		let output .= toOut
		let index += 1
	endwhile

	call setline(line('.'), output)
endfunction
" }}}

" コマンド登録: テスト中につきここに書いてあります {{{1
command! -nargs=1 Tech2cterm echo s:gui2cterm(<q-args>)
command! -nargs=1 Tech2gui echo s:cterm2gui(<q-args>)
command! -nargs=1 Technicolor call technicolor#main(<q-args>)
"}}}

let &cpo = s:save_cpo

" vim: set fdm=marker:
