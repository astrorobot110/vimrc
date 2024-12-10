scriptencoding utf-8

command! -nargs=1 -bang ABC call abc#main(<q-args>, '<bang>')
command! -range Chords :<line1>,<line2>call chordSplitter#main()
command! -range DeLyric call deLyric#main()
