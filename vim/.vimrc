" set UTF-8 encoding
set encoding=utf-8

" enable hybrid line numbers
set number
set relativenumber

" enable syntax highlighting
syntax on

" set shift and tab width to 4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

" highlight matching words while searching
set hlsearch
set incsearch

" enable mouse mode
set mouse=a

" enable TAB autocomplete menu and ignore endings
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" always start vim with block cursor
let &t_ti ..= "\e[2 q"
let &t_te ..= "\e[2 q"

" use different cursors for each vim mode
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" remove delay when pressing Esc
set ttimeout
set ttimeoutlen=1
set ttyfast

" remove vim intro screen
set shortmess+=I

" set space as leader key
nnoremap <Space> <Nop>
let mapleader = " "

" custom mappings
nnoremap Y y$
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
nnoremap <leader>a :%y+<CR>
nnoremap <silent> <leader><leader> :noh<CR>

" KALI
" " use deus colorscheme 
" set t_Co=256
" set termguicolors
" set background=dark
" colorscheme deus
" 
" " vim-airline settings
" set noshowmode 
" set laststatus=2
" let g:airline_theme="deus"
" let g:airline_powerline_fonts = 0
" let g:airline#extensions#whitespace#enabled = 0
" 
" " make background transparent 
" highlight Normal guibg=NONE ctermbg=NONE
" highlight NonText guibg=NONE ctermbg=NONE
" highlight LineNr guibg=NONE ctermbg=NONE
" highlight SignColumn guibg=NONE ctermbg=NONE
" highlight EndOfBuffer guibg=NONE ctermbg=NONE

" UBUNTU 
" statusline settings
" set laststatus=2
" set noshowmode
" 
" let g:currentmode={
"         \ 'n' : 'NORMAL ',
"         \ 'v' : 'VISUAL ',
"         \ 'V' : 'V-LINE ',
"         \ '\' : 'V-BLOCK' ,
"         \ 'i' : 'INSERT ',
"         \ 'R' : 'R ',
"         \ 'Rv' : 'V-REPLACE ',
"         \ 'c' : 'COMMAND ',
"         \}
" 
" set statusline=
" set statusline+=%#Icon#
" set statusline+=\ 𝑽
" set statusline+=\ %#NormalC#%{(mode()=='n')?'\ NORMAL\ ':''}
" set statusline+=%#InsertC#%{(mode()=='i')?'\ INSERT\ ':''}
" set statusline+=%#VisualC#%{(mode()=='v')?'\ VISUAL\ ':''}
" set statusline+=%#Filename#
" set statusline+=\ %f
" set statusline+=%#ReadOnly#
" set statusline+=\ %r
" set statusline+=%m
" set statusline+=%=
" set statusline+=%#Fileformat#
" set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ [%{&fileformat}\]
" set statusline+=%#Position#
" set statusline+=\ [%l/%L]
