scriptencoding utf-8

" ローカルプラグイン

" zoooom
if has('gui')
	nnoremap <C-ScrollWheelUp> :<C-u>call zoooom#setZoom(1)<CR>
	nnoremap <C-ScrollWheelDown> :<C-u>call zoooom#setZoom(-1)<CR>
endif

" zoooom
if has('gui')
	nnoremap Z<ScrollWheelUp> :<C-u>call zoooom#init()<CR>
	nnoremap Z<ScrollWheelDown> :<C-u>call zoooom#init()<CR>
endif

