scriptencoding utf-8

command -nargs=1 -bang -complete=highlight GetHl call getHighlight#main(<q-args>, '<bang>')
