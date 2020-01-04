scriptencoding utf-8

let s:qcPath = g:qcPath
let s:qcExe = g:qcExe

command! QiitaFetch call qiitaCtl#Fetch()
command! -nargs=1 QiitaGenerate call qiitaCtl#Generate(<f-args>)
command! QiitaCreate call qiitaCtl#Create()
command! QiitaUpdate call qiitaCtl#Update()

" リマップ用
command! QiitaFiles vs $VIMFILES/.qiitaCtl.ls | put =escape(glob(s:qcPath.'/**/*.md'),' ')
