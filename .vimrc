colorscheme jellybeans
"colorscheme slate
"colo sorbet
highlight Normal cterm=bold


"cpp,c custimization
"autocmd Filetype cpp,c noremap <TAB> % if this is included then ultisnips not
"working properly 

autocmd Filetype cpp,c inoremap {<cr>   {}<left><cr><esc>ko
"to shift out from {} bracktes 
autocmd Filetype cpp,c noremap <s-tab> <esc> ]}o
autocmd Filetype cpp,c inoremap <s-tab> <esc> ]}o
autocmd Filetype cpp,c command! LLDB :vertical terminal ++shell clang++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g -o "%<" "%" && lldb %<
autocmd Filetype cpp,c noremap <Leader>i : call system('pbpaste > inp' . expand('%<')) <cr>
autocmd Filetype cpp,c noremap <Leader>I :vert terminal ++shell vim inp%< <cr>
autocmd Filetype cpp,c noremap <F10> <ESC>:w<CR> :vertical terminal ++shell ++cols=60 g++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g -o %< % && ./%< < inp%<<CR>
autocmd Filetype cpp,c inoremap <F10> <ESC>:w <CR> :vertical terminal ++shell ++cols=60 g++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow  -DONPC -O2 -g -o "%<" "%" && "./%<"< inp%<<CR>
autocmd Filetype cpp,c noremap <F8> <ESC> :w <CR> :!g++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g -o %< % && ./%< < inp%< <CR>
autocmd Filetype cpp,c inoremap <F8> <ESC> :w <CR> :!g++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g -o "%<" "%" && "./%<" < inp%< <CR>
autocmd Filetype cpp,c noremap <F9> <ESC> :w <CR> :!g++-12 -std=c++20 -Wall -Wextra -Wshadow -O2 -g -o %< % && ./%<  <CR>
autocmd Filetype cpp,c inoremap <F9> <ESC> :w <CR> :!g++-12 -std=c++20 -Wall -Wextra -Wshadow -O2 -g -o %< % && ./%< <CR>
autocmd Filetype cpp,c noremap <F7> <ESC> :w <CR> :vert terminal ++shell ++cols=60 g++-13 -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % && ./%< < inp%< <CR>
autocmd Filetype cpp,c inoremap <F7> <ESC> :w <CR> :vert terminal ++shell ++cols=60 g++-13 -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" < inp%< <CR>
autocmd FileType cpp,c setlocal equalprg=clang-format\ -style=WebKit
autocmd FileType cpp setlocal makeprg=g\+\+\ %\ \-g\ \-std\=c\+\+20\ \-Wall
inoremap jk <Esc>



"python custimizations
noremap <F3> <ESC>:w<CR>:vert terminal ++shell ++cols=60 python3.10 "%"<CR>
inoremap <F3> <ESC>:w<CR>:vert terminal ++shell ++cols=60 python3.10 "%"<CR>
noremap <Leader>d :w<cr>:vert terminal ++shell python3.10 -m pdb "%"<cr>
autocmd FileType python setlocal equalprg=black
autocmd FileType python setlocal makeprg=python3.10\ %


"plugins
call plug#begin('~/.vim/plugged')

"Plug 'lervag/vimtex'
"let g:tex_flavor='latex'
"let g:vimtex_view_method='skim'
"let g:vimtex_quickfix_mode=0
"set conceallevel=1
"let g:tex_conceal='abdmg' 

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsEditSplit="vertical"

Plug 'honza/vim-snippets'

call plug#end()
":PlugInstall

let mapleader = "\<Space>"
noremap <Leader>e :edit 
noremap <Leader>n :vs<cr>
noremap <Leader>wq :wq<CR>
noremap <Leader>q :q<CR>
noremap <Leader>p :bp<CR>
noremap <Leader>n :bn<CR>
noremap <Leader>a ggVG$"*y
noremap <Leader>v :vert terminal ++shell <cr>
noremap <Leader>s :source ~/.vimrc <CR>


"customizations
" adding fzf to runtime path
set rtp+=/opt/homebrew/opt/fzf

" number of colors
set t_Co=256

"set background=dark
"set exrc

"set for latex plugin
set encoding=utf-8 

set autoindent
set autoread
set cin
set expandtab
set history=1000
set hlsearch
set ignorecase
set incsearch
set mousehide
set noerrorbells
set noswapfile
set number
set pastetoggle=
set shiftwidth=4
set smarttab
set tabstop=4
set vb t_vb=
set relativenumber
set nowrap
set scrolloff=15
set shellslash
set splitbelow splitright
set sw=4
set iskeyword+=:
set cursorline
set guifont=*
filetype indent on
filetype plugin on
filetype on
syntax on



" latex related
"noremap <F5> <ESC> :w <CR> :vert terminal ++shell pdflatex -shell-escape main.tex  
"augroup VimTeX
    "autocmd!
    "autocmd BufReadPre /path/to/project/*.tex
                "\ let b:vimtex_main = '/path/to/project/main.tex'
"augroup END
"let g:vimtex_compiler_latexmx = {
            "\ 'options' : [
            "\   '-shell-escape',
            "\   '-verbose',
            "\   '-file-line-error',
            "\   '-synctex=1',
            "\   '-interaction=nonstopmode',
            "\ ],
            "\}
"

"g:Tex_CompileRule_pdf
"g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'



" reset the cursor on start (for older versions of vim, usually not required)
"augroup myCmds
"    au!
"    autocmd VimEnter * silent !echo -ne "\e[2 q"
"augroup END


"cursor settings 
let &t_SI = "\e[4 q"
let &t_EI = "\e[2 q"
" Set block cursor in normal mode
if has('gui_running')
  set guicursor=n-v-c:block-Cursor/lCursor
endif
" Set horizontal line cursor in insert mode
autocmd InsertEnter * set guicursor=i-ci:ver25-Cursor/lCursor
autocmd InsertLeave * set guicursor=n-v-c:block-Cursor/lCursor

" Return to last edit position when opening files (You want this!)
" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  augroup END
endif
