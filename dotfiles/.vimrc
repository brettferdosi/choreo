""""""""""""""""
"""" CONFIG """"
""""""""""""""""

" turn off vi mode - must be first
set nocompatible

" work with system clipboard
set clipboard^=unnamed,unnamedplus

" enable using true (RGB) colors on a compatible
" terminal emulator. the right way to do this is
" probably by gating on specific TERM values
" set termguicolors

" keep 50 lines of history
set history=50

" vertical diffs
set diffopt=vertical,filler

" split bottom and right
set splitright
set splitbelow

" display incomplete commands
set showcmd

" wait for mapping combinations but not keycodes
" (leave insert and visual with esc quickly)
set ttimeoutlen=0

" make space leader (this way so showcmd shows \)
map <Space> <Leader>

" look for ctags
set tags=./tags;/

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

" ctags - show list if multiple matches
nnoremap <C-U> g<C-]>
vnoremap <C-U> g<C-]>
" ctags - open in split
nnoremap <C-W><C-U> <C-W>g]
vnoremap <C-W><C-U> <C-W>g]
" ctags - pop tag stack
nnoremap <C-Y> <C-T>
vnoremap <C-Y> <C-T>

" understand tmux C-Arrows
" (can't set keycodes for <C-Arrows> directly,
" used unused function keys as an indirect
" mapping; using map directly would cause a delay
" leaving insert or visual with esc)
if &term == "screen-256color"
  exec "set <F13>=[1;5A"
  exec "set <F14>=[1;5B"
  exec "set <F15>=[1;5D"
  exec "set <F16>=[1;5C"
  map <F13> <C-Up>
  map <F14> <C-Down>
  map <F15> <C-Left>
  map <F16> <C-Right>
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

" if necessary to soft break, do it
" at word boundaries and show a marker
set linebreak
set showbreak=↪\ 

" match previous line indentation
set autoindent

" don't insert newlines
set textwidth=0
set wrapmargin=0

" default .tex to latex
let g:tex_flavor = "latex"

" non-code editing
augroup not_code
  autocmd!
  autocmd Filetype text,tex,markdown setlocal spell nu nornu
  " text files autoflow to paragraphs by default because they are read
  " directly; use :set fo-=atc to disable wrapping for text files.
  autocmd Filetype text setlocal textwidth=80 fo+=anl
  " tex and markdown should have one sentence per line because they are
  " source; use Goyo to soft-wrap long sentences nicely.
augroup END

" Goyo mapping
nnoremap <Leader><CR> :Goyo<CR>

" nop to make StatusLine != StatusLineNC so
" vim doesn't show carets (see :help StatusLineNC)
autocmd! User GoyoEnter highlight StatusLineNC guibg=green

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

" relative/absolute numbering for code
set rnu
set nu
let textfiletypes = ['tex', 'text', 'markdown']
function! RelativeOn()
  if &buftype != "nofile" && index(g:textfiletypes, &ft) < 0
    set rnu
  endif
endfunction
function! RelativeOff()
  if &buftype != "nofile"&& index(g:textfiletypes, &ft) < 0
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
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/goyo.vim'

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
set background=light
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
