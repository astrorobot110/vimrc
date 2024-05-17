scriptencoding utf-8

let s:ctermTable = [
			\  15,  14,  13,  12,  11,  10,   9,   8,   7,   6,   5,   4,   3,   2,   1,   0, 
			\ 231, 230, 229, 228, 227, 226, 225, 224, 223, 222, 221, 220, 219, 218, 217, 216, 
			\ 215, 214, 213, 212, 211, 210, 209, 208, 207, 206, 205, 204, 203, 202, 201, 200, 
			\ 199, 198, 197, 196, 195, 194, 193, 192, 191, 190, 189, 188, 187, 186, 185, 184, 
			\ 183, 182, 181, 180, 179, 178, 177, 176, 175, 174, 173, 172, 171, 170, 169, 168, 
			\ 167, 166, 165, 164, 163, 162, 161, 160, 159, 158, 157, 156, 155, 154, 153, 152, 
			\ 151, 150, 149, 148, 147, 146, 145, 144, 143, 142, 141, 140, 139, 138, 137, 136, 
			\ 135, 134, 133, 132, 131, 130, 129, 128, 127, 126, 125, 124, 123, 122, 121, 120, 
			\ 119, 118, 117, 116, 115, 114, 113, 112, 111, 110, 109, 108, 107, 106, 105, 104, 
			\ 103, 102, 101, 100,  99,  98,  97,  96,  95,  94,  93,  92,  91,  90,  89,  88, 
			\  87,  86,  85,  84,  83,  82,  81,  80,  79,  78,  77,  76,  75,  74,  73,  72, 
			\  71,  70,  69,  68,  67,  66,  65,  64,  63,  62,  61,  60,  59,  58,  57,  56, 
			\  55,  54,  53,  52,  51,  50,  49,  48,  47,  46,  45,  44,  43,  42,  41,  40, 
			\  39,  38,  37,  36,  35,  34,  33,  32,  31,  30,  29,  28,  27,  26,  25,  24, 
			\  23,  22,  21,  20,  19,  18,  17,  16, 255, 254, 253, 252, 251, 250, 249, 248, 
			\ 247, 246, 245, 244, 243, 242, 241, 240, 239, 238, 237, 236, 235, 234, 233, 232 
			\ ]

function! s:guiFlip(colorStr) abort
	let color = [ a:colorStr[1:2], a:colorStr[3:4], a:colorStr[5:6] ]
	call map(color, {_, val -> eval('0x'..val)})
	let nega = map(color, { _, val -> 255 - val })
	let range = max(nega) + min(nega)
	let comp = map(nega, { _, val -> range - val })
	call map(comp, {_, val -> printf('%02x', val)})
	return '#'..join(comp, '')
endfunction

function! s:colorReplace(line) abort
	let output = ''
	let index = 0
	let param = matchstrpos(a:line, '\(cterm\|gui\)\(fg\|bg\|ul\|sp\)=\(\d\+\|#\x\{6}\)', index)

	while param[1] >= 0
		let output .= a:line[index:param[1]-1]
		let index = param[2]+1

		let [ category, value ] = split(param[0], '=')
		if match(category, 'cterm') == 0
			let value = s:ctermTable[value]
			let format = '%s=%d'
		else
			let value = s:guiFlip(value)
			let format = '%s=%s'
		endif

		let output .= printf(format, category, value)

		let index = param[2]
		let param = matchstrpos(a:line, '\(cterm\|gui\)\(fg\|bg\|ul\|sp\)=\(\d\+\|#\x\{6}\)', index)
	endwhile

	return output..a:line[index:-1]
endfunction

function! niteAndDay#main(first = 0, last = '$') abort range
	let buf = getline(a:first, a:last)
	call map(buf, {_, val -> s:colorReplace(val)})
	new
	call append(0, buf)
endfunction

function! niteAndDay#test(arg) abort
	return s:colorReplace(a:arg)
endfunction
