scriptencoding utf-8

" chordSplitter
command! -range Chords :<line1>,<line2>call chordSplitter#main()

" abc
command! -nargs=1 ABC call abc#main(<q-args>)

" vimtutor
command! -nargs=? Tutorial call vimtutor#main(<f-args>)