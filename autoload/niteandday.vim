scriptencoding utf-8

let s:ctermTable = [
			\  15,  14,  13,  12,  11,  10,   9,   8,   7,   6,   5,   4,   3,   2,   1,   0, 
			\  16,  58, 100, 142, 184, 226,  53,  52,  94, 136, 178, 220,  90,  89,  88, 130,
			\ 172, 214, 127, 126, 125, 124, 166, 208, 164, 163, 162, 161, 160, 202, 201, 200,
			\ 199, 198, 197, 196,  23,  22,  64, 106, 148, 190,  17,  59, 101, 143, 185, 227,
			\  54,  96,  95, 137, 179, 221,  91, 133, 132, 131, 173, 215, 128, 170, 169, 168,
			\ 167, 209, 165, 207, 206, 205, 204, 203,  30,  29,  28,  70, 112, 154,  24,  66,
			\  65, 107, 149, 191,  18,  60, 102, 144, 186, 228,  55,  97, 139, 138, 180, 222,
			\  92, 134, 176, 175, 174, 216, 129, 171, 213, 212, 211, 210,  37,  36,  35,  34,
			\  76, 118,  31,  73,  72,  71, 113, 155,  25,  67, 109, 108, 150, 192,  19,  61,
			\ 103, 145, 187, 229,  56,  98, 140, 182, 181, 223,  93, 135, 177, 219, 218, 217,
			\  44,  43,  42,  41,  40,  82,  38,  80,  79,  78,  77, 119,  32,  74, 116, 115,
			\ 114, 156,  26,  68, 110, 152, 151, 193,  20,  62, 104, 146, 188, 230,  57,  99,
			\ 141, 183, 225, 224,  51,  50,  49,  48,  47,  46,  45,  87,  86,  85,  84,  83,
			\  39,  81, 123, 122, 121, 120,  33,  75, 117, 159, 158, 157,  27,  69, 111, 153,
			\ 195, 194,  21,  63, 105, 147, 189, 231, 255, 254, 253, 252, 251, 250, 249, 248,
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
