scriptencoding utf-8

let s:apiUrl = 'https://haiden.sakura.ne.jp/sp/dno_api.php?dno='

function! s:getInfo(number) abort
	let xml = system('curl -s '..s:apiUrl..a:number)
	let info = { 'number':  a:number }
	let info['address'] = substitute(xml, '.*<address>\(.\+\)<\/address>.*', '\=submatch(1)', '')
	let info['lat'] = substitute(xml, '.*<Lat>\([0-9\.]\+\)<\/Lat>.*', '\=submatch(1)', '')
	let info['lon'] = substitute(xml, '.*<Lon>\([0-9\.]\+\)<\/Lon>.*', '\=submatch(1)', '')
	let info['url'] = printf('https://maps.google.com/maps?q=%s,%s', info.lat, info.lon)

	return info
endfunction

function! s:getText(info) abort
	return join( [
				\ printf('number:  %s',   a:info.number ),
				\ printf('address: %s',   a:info.address ),
				\ printf('url:     <%s>', a:info.url ) ],
				\ nr2char(0x0a) )
endfunction

function! denchu#main(number, isBang = '') abort
	let info = s:getInfo(a:number)
	if a:isBang ==? '!'
		call execute('split denchu_'..info.number)
		call setline(1, split(s:getText(info), nr2char(0x0a)))
		call system(printf('pwsh -c "start \"%s\""', info.url))
	else
		call execute('put =s:getText(info)')
	endif
endfunction
