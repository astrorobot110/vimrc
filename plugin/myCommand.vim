scriptencoding utf-8

" chordSplitter
command! -range Chords :<line1>,<line2>call chordSplitter#main()

" abc
command! -nargs=1 ABC call abc#main(<q-args>)

" vimtutor
command! -nargs=? Tutorial call vimtutor#main(<f-args>)

"Phonetic
command! -nargs=? -bang Phone call phonetic#main(<f-args>, "<bang>")
command! -nargs=1 PhoneEcho echo phonetic#generate(<f-args>)
