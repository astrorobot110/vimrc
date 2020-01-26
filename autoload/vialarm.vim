scriptencoding utf-8

let s:timeZone = exists('g:vialarm_timeZone') ? g:vialarm_timeZone : 0

let s:vialarmList = []

let s:Vialarm = {
		\ 'timeText': '',
		\ 'timeSeconds': 0,
		\ 'timer': ''
		\ }

function! s:Vialarm.setTime(timeText) abort
	try
		if match(a:timeText, '^\d\d:\d\d$') >= 0
			let self.timeText = a:timeText

			let time = split(self.timeText, ':')
			if time[0] < 24 || time[1] < 60
				let self.timeSeconds = ( time[0] * 60 + time[1] ) * 60
			else
				throw 'vialarm_E12'
			endif
		else
			throw 'vialarm_E11'
		endif
	catch /vialarm_E11/
		echoerr 'Error in setTime(): Args isn''t "TimeText".'
	catch /vialarm_E21/
		echoerr 'Error in setTime(): Alarm time not specify.'
	endtry
endfunction

function! s:Vialarm.setTimer() abort
	" 1 day is 60*60*24 seconds.
	let currentSeconds = (localtime() + s:timeZone * 3600) % 86400
	let currentTimer = (86400 + self.timeSeconds - currentSeconds) % 86400
	let self.timer = timer_start(currentTimer*1000, self.inTime)
endfunction

function! s:Vialarm.inTime(timer) abort
	execute 'doautocmd' 'vialarm' 'user' self.timeText
	let self.timer = timer_start(86400000, self.inTime, {'repeat': -1})
endfunction

function! s:init() abort
	if len(s:vialarmList) > 0
		let s:vialarmList = []
	endif

	try
		let alarms = split(execute('autocmd vialarm'), '[\n]')[2:]
	catch /E216/
		echo 'No alarms.'
	endtry

	for val in alarms
		let newOne = deepcopy(s:Vialarm)
		call newOne.setTime(matchstr(val, '\d\d:\d\d'))
		call add(s:vialarmList, deepcopy(newOne))
	endfor

	return s:vialarmList
endfunction

function! s:getList() abort
	echo s:vialarmList
endfunction

function! s:setTimer() abort
	for v in s:vialarmList
		call v.setTimer()
	endfor
endfunction

command VialarmInit call s:init()
command VialarmList call s:getList()
command VialarmSet call s:setTimer()
