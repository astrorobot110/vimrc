scriptencoding utf-8

if !exists('g:deStainMarks')
	let g:deStainMarks = [
	\	[	'`',  '`',  '!',  '@',  '#',  '$',  '%',  '^',
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

function! deStain#main() abort
	let char = matchstr(getline('.'), '.', col('.')-1)
	let isFullMark = char2nr(char) < 128 ? 0 : 1
	let m = match(g:deStainMarks[isFullMark], escape(char, '\.*^$[~/'))
	if m >= 0
		execute 'normal r'.g:deStainMarks[!isFullMark][m]
	endif
endfunction
