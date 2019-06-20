scriptencoding utf-8

" 一応明示的に書いておくやつ
set iminsert=0
set imsearch=-1

" iM操作用
if has('multi_byte_ime')
	augroup autoIM
		autocmd!
		autocmd InsertLeave * set iminsert=0
		autocmd CmdlineLeave * set iminsert=0
	augroup END
endif
