scriptencoding utf-8

if isdirectory(expand(g:drWorkPath))
	packadd dailyreading
endif

if executable('qiitactl') && exists('$QIITA_ACCESS_TOKEN')
	packadd qiitactl
endif

if exista(g:hymnalaPath) && isdirectory(expand(g:hymnalaPath))
	packadd hymnala
endif
