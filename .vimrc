set nocompatible
set number 


"syntax enable
"colorscheme monokai

syntax on
"colorscheme sublimemonokai

"let g:go_highlight_format_strings = 1
"let g:go_highlight_function_arguments = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_types = 1

"let g:go_highlight_extra_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_generate_tags = 1
"let g:go_highlight_variable_assignments = 1
"let g:go_highlight_variable_declarations = 1

"call plug#begin('~/.vim/bundle')

"Plug 'ycm-core/YouCompleteMe'
"Plug 'fatih/vim-go'
"Plug 'takac/vim-hardtime'
"Plug 'nightsense/snow'
"Plug 'itchyny/lightline.vim'

"let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"let g:hardtime_default_on = 1

"call plug#end()

set incsearch

nmap <space>q :q<CR>
nmap <space>w :w<CR>
nmap <space>r :GoRun<CR>
nmap <space>b :GoBuild<CR>
nmap <space>i :GoImports<CR>

set clipboard=unnamedplus

set cino=(s,m1,+0,L0

set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=2

"colorscheme eighties
"colorscheme snow
