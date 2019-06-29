scriptencoding utf-8

command! -bang OpenReading call dailyReading#open('<bang>')
command! -nargs=? -bang ExportReading call dailyReading#dailyReading('<bang>', <q-args>)
