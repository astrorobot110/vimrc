scriptencoding utf-8

function! closer#main() abort
    let bracketList = {}
    let bracketList['open'] = filter(split(&matchpairs, '[:,]'), 'v:key % 2 == 0')
    let bracketList['close'] = filter(split(&matchpairs, '[:,]'), 'v:key % 2 == 1')
    let isFound = 0

    let pos = getcurpos()

    while search('['.escape(substitute(&matchpairs, '[:,]', '', 'g'), '\.*^$]~/').'"'''.']', 'bW') > 0
        let foundBracket = matchstr(getline('.'), '.', col('.')-1)

        if foundBracket ==# ''''
            call searchpair('''','','''','bW')
        elseif foundBracket ==# '"'
            call searchpair('[^\\]/zs"','','"','bW')
        else
            let idx = match(bracketList.close, foundBracket)
            if idx > -1
                call searchpair(
                        \ escape(bracketList.open[idx], '/.*^$]~\'),
                        \ '',
                        \ escape(bracketList.close[idx], '/.*^$]~\'),
                        \ 'bW')
            else
                let isFound = 1
                break
            endif
        endif
    endwhile

    call setpos('.', pos)
    return isFound ? bracketList.close[match(bracketList.open, foundBracket)] : ''
endfunction

function! closer#fromNormal(isBang) abort
    let @c = closer#main()
    if @c !=# '' && a:isBang ==# '!'
        execute 'normal "cPl'
    else
        echo @c !=# '' ? 'Bracket : '.@c : 'No bracket to close.'
    endif
endfunction
