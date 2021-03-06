scriptencoding utf-8

let b:report_fileList = glob(expand('%:p:h')..'/*.'..expand('%:e'), 1, 1)
		\ ->filter('v:val =~# ''\d\{6}\.md''')

nnoremap <buffer> ]r :<C-u>call report#main(v:count1)<CR>
nnoremap <buffer> [r :<C-u>call report#main(-v:count1)<CR>
nnoremap <buffer> ]R :<C-u>execute 'edit!' b:report_fileList[-1]<CR>
nnoremap <buffer> [R :<C-u>execute 'edit!' b:report_fileList[0]<CR>

if &filetype ==# 'report'
	setlocal filetype=markdown
endif
