scriptencoding utf-8

let s:id_app = exists('g:id_app') ? g:id_app : 'EZLY4P4VLQdC'

function! textra#main(from='en', to='ja') range abort
	if mode() !~# '^[vV\x16]'
		let selected = getline(a:firstline, a:lastline)
	else
		let selected = getregion(getpos('.'), getpos('v'), { "type": mode() })
	endif

	let o_text = map(selected, { _, val -> escape(val, '"\/') })->join('\n')

	let json =<< eval EOF
{{
"TexTra Clipboard":
{{
"id_app": "{s:id_app}",
"o_text": "{o_text}",
"o_lang": "{a:from}",
"t_lang": "{a:to}",
"time_request" : "{strftime('%x %X')}"
}}
}}
EOF

	call join(json, " ")->setreg('*')

endfunction
