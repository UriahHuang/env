""" unset unwanted setting
unmap <space>
unmap <c-space>

""" map l, L to next, previous buffer
unmap <leader>h
nmap <leader>L :bp<cr>

""" ale
let g:ale_python_flake8_args = '--ignore=E,W --select=F,E999'
"nmap <silent> <F1> :ALENextWrap<cr>
"nmap <silent> <F2> :ALEPreviousWrap<cr>
let b:ale_fixers = {
\    'python': ['autopep8']
\}
let g:ale_fix_on_save = 1

""" braces
inoremap $1 (<cr><esc>o)<up><left><tab><esc>$a
inoremap $2 [<cr><esc>o]<up><left><tab><esc>$a
inoremap $3 {<cr><esc>o}<up><left><tab><esc>$a
inoremap $q '<cr><esc>o'<up><left><tab><esc>$a
inoremap $$ "<cr><esc>o"<up><left><tab><esc>$a

