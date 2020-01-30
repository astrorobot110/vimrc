scriptencoding utf-8

let s:oneshots = []

function! s:init() abort
	try
		let s:alarms = split(execute('autocmd vialarm'), '[\n]')[2:]
		call map(s:alarms, { _, val -> matchstr(val,'\d\d:\d\d') })
	catch /E216/
		let s:alarms = []
	endtry

	if exists('s:vialarmTimer')
		call timer_stop(s:vialarmTimer)
	endif
	let s:vialarmTimer = timer_start((60-(localtime()%60))*1000, function('s:getAlarm'))

	if v:vim_did_enter
		echo 'Vialarm: initialized.'
	endif
endfunction

function! s:getAlarm(timer) abort
	let now = strftime('%H:%M', localtime())
	if count(s:alarms + s:oneshots, now) > 0
		execute 'doautocmd User' now

		if match(s:oneshots, now) > -1
			call filter(s:oneshots, { key, val -> val !=# now })
		endif
	endif

	if timer_info(s:vialarmTimer)[0].repeat > 0
		let s:vialarmTimer = timer_start(60000, function('s:getAlarm'), {'repeat':-1})
	endif
endfunction

function! s:addOneshot(time, command) abort
	try
		if match(a:time, '^\d\d:\d\d$') < 0
			throw 'vialarm_E01'
		endif

		if matchstr(a:time, '^\d\d') > 23 || matchstr(a:time, '\d\d$') > 59
			throw 'vialarm_E02'
		endif

		if a:command ==# ''
			throw 'vialarm_E03'
		endif

		execute 'autocmd vialarm User' a:time '++once' a:command
		call add(s:oneshots, a:time)

		echo printf('[vialarm] Added alarm in %s.', a:time)
	catch /vialarm_E01/
		echoerr '[vialarm] Error: Time format must be ''HH:MM''.'
	catch /vialarm_E02/
		echoerr '[vialarm] Error: No such time. :('
	catch /vialarm_E03/
		echoerr '[vialarm] Error: Command is empty.'
	endtry
endfunction

function! vialarm#main(args, isBang) abort
	if a:isBang ==# ''
		if a:args !=# ''
			let time = matchstr(a:args, '^\S*')
			let command = matchstr(a:args, '\s\zs.*$')
			call s:addOneshot(time, command)
		else
			echo 'You can also get vialarm info from ":autocmd vialarm".'
			autocmd vialarm
		endif
	else
		call s:init()
	endif
endfunction

function! vialarm#stop() abort
	call timer_stop(s:vialarmTimer)
	echo 'Vialarm was stopped. execute '':Vialarm'' if you want start vialarm again.'
endfunction

function! vialarm#getTimerInfo() abort
	return timer_info(s:vialarmTimer)[0]
endfunction

function! vialarm#peek() abort
	return s:alarms + s:oneshots
endfunction
