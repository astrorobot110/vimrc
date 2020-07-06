scriptencoding utf-8

let s:Vital = vital#of('vital')
let s:DateTime = s:Vital.import('DateTime')

function! report#main(direction) abort
	let current = match(b:report_fileList, expand('%:t'))
	let target = current + a:direction

	if current > -1 && sort([0, target, len(b:report_fileList)-1], 'n')[1] == target
		let targetFile = b:report_fileList[target]
	else
		let fileDate = s:DateTime.from_format(expand('%:t:r'), '%y%m%d')
		let delta = s:DateTime.delta(a:direction, 0)

		let targetName = fileDate.to(delta).format('%y%m%d')
		let targetFile = printf('%s/%s.%s',
				\ expand('%:p:h'),
				\ fileDate.to(delta).format('%y%m%d'),
				\ expand('%:e')
				\ )
	endif

	if targetFile !=# expand('%:p:h')
		execute 'edit!' fnameescape(targetFile)
	endif
endfunction
