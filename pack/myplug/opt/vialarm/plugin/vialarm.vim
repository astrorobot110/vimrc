scriptencoding utf-8

command! -bang -nargs=* -complete=command Vialarm call vialarm#main(<q-args>, '<bang>')

Vialarm! start
