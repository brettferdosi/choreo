""""""""""""""""
"""" CONFIG """"
""""""""""""""""

" allow project local config
set exrc

" block malicious project local config
set secure

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
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

"split resize"
noremap <C-Up> <C-w>5+
noremap <C-Down> <C-w>5-
noremap <C-Left> <C-w>5<
noremap <C-Right> <C-w>5>

" navigate wrapped lines
noremap j gj
noremap k gk

" understand tmux C-Arrows
if &term == "screen"
    map <esc>[1;5A <C-Up>
    map <esc>[1;5B <C-Down>
    map <esc>[1;5D <C-Left>
    map <esc>[1;5C <C-Right>
endif

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

"default .tex to latex
let g:tex_flavor = "latex"

" format and spellcheck when editing text
augroup text
  autocmd!
  autocmd Filetype text,tex setlocal textwidth=80 spell
augroup END

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
set ignorecase
" searches starting with capital are case sensitive
set smartcase
" return clears highlighting
nnoremap <CR> :noh<CR>
" /g default for replaces
set gdefault

" double space toggles folding
nnoremap <Leader><space> za

" fast leaving insert mode with esc
augroup escapeinsert
  autocmd!
  autocmd InsertEnter * set timeoutlen=0
  autocmd InsertLeave * set timeoutlen=1000
augroup END

" intelligent relative/absolute numbering
set rnu
set nu
function! RelativeOn()
  if &buftype != "nofile"
    set rnu
  endif
endfunction
function! RelativeOff()
  if &buftype != "nofile"
    set nornu
  endif
endfunction
augroup numbering
  autocmd!
  autocmd WinLeave,InsertEnter * call RelativeOff()
  autocmd WinEnter,InsertLeave * call RelativeOn()
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
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'

call vundle#end()

noremap <C-n> :NERDTree<CR>
let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapOpenSplit="s"

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

" change sign column background color
highlight SignColumn ctermbg=238
