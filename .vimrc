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
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" navigate wrapped lines
noremap j gj
noremap k gk

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

" spellcheck and format when editing text
augroup text
  autocmd!
  autocmd Filetype text,tex setlocal textwidth=80
  autocmd Filetype text,tex setlocal spell spelllang=en
augroup END

" set default tex mode to latex
let g:tex_flavor = "latex"

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

" completion popup options
set completeopt=menuone,preview,longest

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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'

call vundle#end()

" don't check when quitting
let g:syntastic_check_on_wq = 0

" opening NERDTree doesn't trigger BufLeave
map <C-n> :call NumbersOn() <bar> :NERDTree<CR>
let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapOpenSplit="s"

" use context supertab completion with keyword default
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"

" restore filetype plugin/indents
filetype plugin indent on

" language support
setlocal omnifunc=syntaxcomplete#Complete
augroup lang
  autocmd!
  autocmd FileType c
    \ setlocal omnifunc=ccomplete#Complete |
    \ let b:SuperTabContextDefaultCompletionType = "<c-p>" |
    \ map <C-c> :!ctags -R .<CR>
  autocmd FileType java
    \ call SuperTabChain(&omnifunc, "<c-p>") |
    \ let b:SuperTabContextDefaultCompletionType = "<c-x><c-u>"
  autocmd FileType tex
    \ map <C-c> :!pdflatex '%:p'<CR>
augroup END

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

" change omnicomplete box background color
highlight Pmenu ctermbg=238

" change sign column background color
highlight SignColumn ctermbg=238
