scriptencoding utf-8

if !exists('g:deStainMarks')
	let g:deStainMarks = [
	\	[	'`',  '~',  '!',  '@',  '#',  '$',  '%',  '^',
	\		'&',  '*',  '(',  ')',  '_',  '-',  '+',  '=',
	\		'[',  ']',  '{',  '}',  ';',  ':',  '''', '"',
	\		'<',  '>',  ',',  '.',  '/',  '?',  '|',  '\',
	\		' '
	\	],
	\	[	'｀', '￣', '！', '＠', '＃', '＄', '％', '＾',
	\		'＆', '＊', '（', '）', '＿', 'ー', '＋', '＝',
	\		'［', '］', '｛', '｝', '；', '：', '’', '”',
	\		'＜', '＞', '、', '。', '／', '？', '｜', '＼',
	\		'　'
	\	]
	\]
endif

function! deStain#main(...) abort
	let charOnCursor = matchstr(getline('.'), '.', col('.')-1)
	let isFullMark = char2nr(charOnCursor) < 128 ? 0 : 1
	let m = match(g:deStainMarks[isFullMark], escape(charOnCursor, '\.*^$[~/'))
	if m >= 0
		execute 'normal r'..g:deStainMarks[!isFullMark][m]
	elseif a:0 > 0
		let charInFunction = slice(a:1, 0, 1)
		let isFullMark = char2nr(charInFunction) < 128 ? 0 : 1
		let n = match(g:deStainMarks[isFullMark], escape(charInFunction, '\.*^$[~/'))
		if n >= 0
			execute 'normal i'..charInFunction..'[`'
		endif
	endif
endfunction

" テスト文字列
" サーバー
" 表示
