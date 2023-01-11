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

function! denchu#main(number) abort
	let info = s:getInfo(a:number)
	new
	call setline(1,  printf('number:  %s',   info.number ))
	call append('$', printf('address: %s',   info.address ))
	call append('$', printf('url:     <%s>', info.url ))
	call printf('powershell -c "start %s"', "'"..info.url.."'")->system()
endfunction
