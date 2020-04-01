setlocal fileformat=unix

" Zsのトラブル頻発してるので退避
nnoremap <buffer> Zs :<C-u>source %<CR>

" 改行忘れ用
nnoremap <buffer> <C-]><CR> A<CR>
nnoremap <buffer> <C-]><C-CR> A<CR>
