""" unset unwanted setting
unmap <space>
unmap <c-space>

""" map l, L to next, previous buffer
unmap <leader>h
nmap <leader>L :bp<cr>

""" ale
let g:ale_python_flake8_options = '--ignore=E,W --select=F,E999'
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

""" insert mode common operation
" delete word/WORD/end left/right
inoremap a<left> <esc><right>dbi
inoremap q<left> <esc><right>dBi
inoremap d<left> <esc><right>d^i
inoremap a<right> <esc><right>dei
inoremap q<right> <esc><right>dEi
inoremap d<right> <esc><right>d$a
" move word/WORD/end left/right
inoremap s<left> <esc>bi
inoremap w<left> <esc>Bi
inoremap f<left> <esc>^i
inoremap s<right> <esc>ea
inoremap w<right> <esc>Ea
inoremap f<right> <esc>$a

