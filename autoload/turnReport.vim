scriptencoding utf-8

let s:Vital = vital#of('vital')
let s:DateTime = s:Vital.import('DateTime')

function! s:turnFile(direction) abort
	if filereadable(expand('%'))
		let directory = expand('%:p:h')
		let fileName = expand('%:t:r')
		let fileExt = expand('%:e')

		let fileList = split(glob(directory..'/*.'..fileExt), '\n')

		let current = match(fileList, fileName)
		let target = current + a:direction

		if target < 0
			if current == 0
				echo 'This is first file.'
			else
				echo 'Can''t traced back to the first file, so loading first file.'
			endif
		elseif target > len(fileList) - 1
			if current == len(fileList) - 1
				echo 'This is last file.'
			else
				echo 'Can''t traced over to the last file, so loading last file.'
			endif
		endif

		return fileList[sort([0, target, len(fileList) - 1], 'n')[1]]
	else
		echo 'Save file before turn report.'
		return ''
	endif
endfunction

function! s:turnForce(direction) abort
	let directory = expand('%:p:h')
	let fileName = expand('%:t:r')
	let fileExt = expand('%:e')

	let fileDate = s:DateTime.from_format(fileName, '%y%m%d')
	let delta = s:DateTime.delta(a:direction, 0)

	let fileName = fileDate.to(delta).format('%y%m%d')

	return directory..'/'..fileName..'.'..fileExt
endfunction

function! turnReport#main(direction, ...) abort
	let isBang = a:0 > 0 && a:1 ==# '!'

	let targetFile = isBang ? s:turnForce(a:direction) : s:turnFile(a:direction)

	if targetFile != '' || targetFile !=# expand('%:p:h')
		execute 'file' fnameescape(targetFile)
		execute 'edit!'
	endif
endfunction

