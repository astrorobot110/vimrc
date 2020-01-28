scriptencoding utf-8

let s:timeZone = exists('g:vialarm_timeZone') ? g:vialarm_timeZone : 0

if !exists('s:vialarmList')
	let s:vialarmList = []
endif

let s:Vialarm = {
		\ 'timeText': '',
		\ 'timeSeconds': 0,
		\ 'timerID': 0,
		\ 'command': '',
		\ }

function! s:Vialarm.getParam(timeText, command) abort
	try
		if match(a:timeText, '^\d\d:\d\d$') >= 0
			let time = split(a:timeText, ':')
			if time[0] < 24 && time[1] < 60
				let self.timeText = a:timeText
				let self.timeSeconds = ( time[0] * 60 + time[1] ) * 60
				let self.command = a:command
			else
				throw 'vialarm_E12'
			endif
		else
			throw 'vialarm_E11'
		endif
	catch /vialarm_E11/
		echoerr 'Error in getParam(): Args isn''t "TimeText", like "HH:MM".'
	catch /vialarm_E12/
		echoerr 'Error in getParam(): Alarm time not specify.'
	endtry
endfunction

function! s:Vialarm.timerSet() abort
	" 1 day is 60*60*24 seconds.
	let currentSeconds = (localtime() + s:timeZone * 3600) % 86400
	let currentTimer = (86400 + self.timeSeconds - currentSeconds) % 86400
	let g:currentTimer = currentTimer
	let self.timerID = timer_start(currentTimer*1000, self.inTime)
endfunction

function! s:Vialarm.inTime(timer) abort
	execute 'doautocmd' 'vialarm' 'user' self.timeText
	let self.timerID = timer_start(86400000, self.inTime)
endfunction

function! vialarm#init() abort
	if !empty(s:vialarmList)
		for val in s:vialarmList
			call timer_stop(val.timerID)
		endfor
		call filter(s:vialarmList, 0)
	endif

	try
		let alarms = split(execute('autocmd vialarm'), '[\n]')[2:]
	catch /E216/
		let alarms = []
	endtry

	for val in alarms
		let newVialarm = deepcopy(s:Vialarm)
		call newVialarm.getParam(matchstr(val, '\d\d:\d\d'), matchstr(val, '\s\{5}\zs.*'))
		call newVialarm.timerSet()
		call add(s:vialarmList, newVialarm)
	endfor

	if v:vim_did_enter
		echo 'Vialarm: initialized.'
	endif
endfunction

function! vialarm#showList() abort
	let outText = []
	for val in s:vialarmList
		let timerID = val.timerID > 0 ? printf('[TimerID:%8d] ', val.timerID) : ''
		call add(outText, printf('%s%s: %s', timerID, val.timeText, val.command))
	endfor

	return empty(outText) ? 'No alarms.' : outText->join("\n")
endfunction
