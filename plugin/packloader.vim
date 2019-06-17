scriptencoding utf-8

if exists('g:drWorkPath') && isdirectory(expand(g:drWorkPath))
	packadd dailyreading
endif

if executable(g:qcExe) && exists('$QIITA_ACCESS_TOKEN') && isdirectory(expand(g:qcPath))
	packadd qiitactl
endif

if exists('g:hymnalaPath') && isdirectory(expand(g:hymnalaPath))
	packadd hymnala
endif
