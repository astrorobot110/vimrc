scriptencoding utf-8

augroup dailySave
	autocmd!
	autocmd CursorHold,CursorHoldI * call dailySave#main()
augroup END

command! DailySave call dailySave#main()
