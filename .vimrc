""""""""""""""""
"""" CONFIG """"
""""""""""""""""

" turn off vi mode - must be first
set nocompatible

" keep 50 lines of history
set history=50

" vertical diffs
set diffopt+=vertical

" split bottom and right
set splitright
set splitbelow

" display incomplete commands
set showcmd

" make space leader (this way so showcmd shows \)
map <Space> <Leader>

""""""""""""""""""
"""" BINDINGS """"
""""""""""""""""""

" split movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" navigate wrapped lines
nnoremap j gj
nnoremap k gk

""""""""""""""""
"""" EDITOR """"
""""""""""""""""

" tabs are 2 spaces
set tabstop=2
" insert spaces for tab
set expandtab
" > indents 2 spaces
set shiftwidth=2
" round > indents
set shiftround

" display tabs, nbsps, and trailing spaces
set list listchars=tab:»·,trail:·,nbsp:·

" match previous line indentation
set autoindent

" don't insert newlines
set textwidth=0
set wrapmargin=0

" highlight matches
set showmatch

" match chevrons
set matchpairs+=<:>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" start scrolling 8 lines from borders
set scrolloff=8

" search highlighting
set hlsearch
" incremental searching
set incsearch
" return stops the search
nnoremap <CR> :noh<CR><CR>
set ignorecase
" searches starting with capital are case sensitive
set smartcase
" /g default for replaces
set gdefault

" intelligent relative/absolute numbering
set rnu
function! RelativeOn()
  if &buftype != "nofile"
    set nonu
    set rnu
  endif
endfunction
function! NumbersOn()
  if &buftype != "nofile"
    set nornu
    set nu
  endif
endfunction
augroup numbering
  autocmd!
  autocmd FocusLost * call NumbersOn()
  autocmd FocusGained * call RelativeOn()
  autocmd BufLeave * call NumbersOn()
  autocmd BufEnter * call RelativeOn()
  autocmd InsertEnter * call NumbersOn()
  autocmd InsertLeave * call RelativeOn()
augroup END

"""""""""""""""""
"""" PLUGINS """"
"""""""""""""""""
" run :PluginInstall to install plugins

" vundle init
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" opening NERDTree doesn't trigger BufLeave
map <C-n> :call NumbersOn() <bar> :NERDTree<CR>
let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapOpenSplit="s"

" choose completion context intelligently
let g:SuperTabDefaultCompletionType = "context"

" restore filetype plugin/indents
filetype plugin indent on

""""""""""""""""
"""" VISUAL """"
""""""""""""""""

" syntax highlighting and color scheme
syntax enable
set background=dark
colo default 

" always show status line
set laststatus=2

" configure status line
set statusline=%t       " tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}] " file format
set statusline+=%h      " help file flag
set statusline+=%m      " modified flag
set statusline+=%r      " read only flag
set statusline+=%y      " filetype
set statusline+=%=      " left/right separator
set statusline+=%c,     " cursor column
set statusline+=%l/%L   " cursor line/total lines
set statusline+=\ %P    " percent through file

" change status line background color
highlight StatusLine ctermfg=238
highlight StatusLineNC ctermfg=238

" change vertical split bar background color
highlight VertSplit ctermfg=238
" remove vertical split bar |
set fillchars+=vert:\ 

" change text width column's background color
highlight ColorColumn ctermbg=red
" highlight text width column for offending lines
call matchadd("ColorColumn", "\%101v", -1)

" change omnicomplete box background color
highlight Pmenu ctermbg=238

" change sign column background color
highlight SignColumn ctermbg=238
