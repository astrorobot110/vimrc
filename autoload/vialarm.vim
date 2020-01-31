scriptencoding utf-8

function! vialarm#timerSwitch(...) abort
	if a:0 > 0 && a:1 ==? 'start'
		call s:timerStart()
	elseif a:0 > 0 && a:1 ==? 'stop'
		call s:timerStop()
	endif
endfunction

function! s:timerStart() abort
	let s:vialarmTimer = timer_start((60-(localtime()%60))*1000, function('s:getAlarm'))

	if v:vim_did_enter
		echo '[vialarm]: start alarm.'
	endif
endfunction

function! s:timerStop() abort
	call timer_stop(s:vialarmTimer)
	unlet s:vialarmTimer
	echo '[vialarm]: Stop alarm.'
endfunction

function! s:getAlarm(timer) abort
	let now = strftime('%H:%M', localtime())
	let autocmdText = split(execute('autocmd User'),'\n')
	if match(autocmdText, '^\s\+vialarm_'.now) > 0
		execute 'doautocmd User' now
	endif

	if timer_info(s:vialarmTimer)[0].repeat > 0
		let s:vialarmTimer = timer_start(60000, function('s:getAlarm'), {'repeat':-1})
	endif
endfunction

function! s:addOneshot(time, command) abort
	try
		if match(a:time, '^\d\d:\d\d$') < 0
			throw 'vialarm_E01'
		elseif matchstr(a:time, '^\d\d') > 23 || matchstr(a:time, '\d\d$') > 59
			throw 'vialarm_E02'
		elseif a:command ==# ''
			throw 'vialarm_E03'
		endif

		execute 'augroup vialarm_oneshots | autocmd User' 'vialarm_'.a:time '++once' a:command
		echo printf('[vialarm]: Added alarm in %s.', a:time)

	catch /vialarm_E01/
		echoerr '[vialarm] Error: Time format must be ''HH:MM''.'
	catch /vialarm_E02/
		echoerr '[vialarm] Error: No such time. :('
	catch /vialarm_E03/
		echoerr '[vialarm] Error: Command is empty.'
	endtry
endfunction

function! s:getAlarmList() abort
	let autocmdText = split(execute('autocmd User'), '\n')[1:]
	let outText = ''

	let group = ''
	let isHit = 0
	for txt in autocmdText
		if isHit
			let outText .= txt."\n"
			let isHit = 0
		elseif match(txt, '^\S') >= 0
			let group = txt
		elseif match(txt, '^\s\+vialarm') >= 0
			if len(group) > 0
				let outText .= group."\n"
				let group = ''
			endif
			let outText .= txt."\n"
			let isHit = match(txt, '\d\d:\d\d$') >= 0 ? 1 : 0
		endif
	endfor

	return outText
endfunction

function! vialarm#main(args) abort
	if a:args !=# ''
		let time = matchstr(a:args, '^\S*')
		let command = matchstr(a:args, '\s\zs.*$')
		call s:addOneshot(time, command)
	else
		echo s:getAlarmList()
	endif
endfunction

function! vialarm#getTimerInfo() abort
	return timer_info(s:vialarmTimer)[0]
endfunction
