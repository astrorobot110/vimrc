scriptencoding utf-8

augroup dailySave
	autocmd!
	autocmd CursorHold,CursorHoldI * echo dailySave#main()
augroup END
