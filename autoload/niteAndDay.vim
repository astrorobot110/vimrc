scriptencoding utf-8

let s:ctermTable = [
			\  15,  14,  13,  12,  11,  10,   9,   8,   7,   6,   5,   4,   3,   2,   1,   0, 
			\ 231, 189, 147, 105,  63,  21, 194, 195, 153, 111,  69,  27, 157, 158, 159, 117,
			\  75,  33, 120, 121, 122, 123,  81,  39,  83,  84,  85,  86,  87,  45,  46,  47,
			\  48,  49,  50,  51, 224, 225, 183, 141,  99,  57, 230, 188, 146, 104,  62,  20,
			\ 193, 151, 152, 110,  68,  26, 156, 114, 115, 116,  74,  32, 119,  77,  78,  79,
			\  80,  38,  82,  40,  41,  42,  43,  44, 217, 218, 219, 177, 135,  93, 223, 181,
			\ 182, 140,  98,  56, 229, 187, 145, 103,  61,  19, 192, 150, 108, 109,  67,  25,
			\ 155, 113,  71,  72,  73,  31, 118,  76,  34,  35,  36,  37, 210, 211, 212, 213,
			\ 171, 129, 216, 174, 175, 176, 134,  92, 222, 180, 138, 139,  97,  55, 228, 186,
			\ 144, 102,  60,  18, 191, 149, 107,  65,  66,  24, 154, 112,  70,  28,  29,  30,
			\ 203, 204, 205, 206, 207, 165, 209, 167, 168, 169, 170, 128, 215, 173, 131, 132,
			\ 133,  91, 221, 179, 137,  95,  96,  54, 227, 185, 143, 101,  59,  17, 190, 148,
			\ 106,  64,  22,  23, 196, 197, 198, 199, 200, 201, 202, 160, 161, 162, 163, 164,
			\ 208, 166, 124, 125, 126, 127, 214, 172, 130,  88,  89,  90, 220, 178, 136,  94,
			\  52,  53, 226, 184, 142, 100,  58,  16, 255, 254, 253, 252, 251, 250, 249, 248,
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
