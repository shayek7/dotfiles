set nocompatible      " Use  VIM - Vi IMproved. 
set title             " Set the terminal's title.                  
set number           " Show line numbers.
syntax on             " Turn on syntax highlighting.
set gcr=a:blinkon0

set showmatch         " Show matching Brackets When text indicator is over them
set mat=1             " How many seconds to blink when matching brackets
"set cursorline        " Highlight current line.

set wrap              " Turn on line wrapping.
set backspace=indent,eol,start  " Intuitive backspacing.

set noswapfile
set nobackup          " Don't make a backup before overwriting a file.

set smartindent
set autoindent
set tabstop=4         " Global tab width.
set shiftwidth=4 
set softtabstop=4
set expandtab         " Use spaces instead of tabs.

set scrolloff=10      " Show minimum 10 lines under cursor. 

set ttyfast
set background=dark 
set encoding=utf-8 
set showmode          " Display the mode you're in.
set ruler             " Show cursor position.
set laststatus=1      " Show the status line all the time
set numberwidth=1

set cmdheight=1       " Height of the command bar
set showcmd           " Display incomplete commands.
set t_Co=256
set t_md=             " Turn off Bold fonts
set shell=bash
set history=500       " How many lines of history VIM has to remember.
set autoread          " Auto read when a file is changed from outside.

set ignorecase " Case-insensitive searching.
set smartcase  " But case-sensitive if expression contains a capital letter.
set hlsearch   " Highlight matches.
set incsearch  " Highlight matches as you type.
set linespace=0 " No extra spaces between rows.
set winminheight=0 " Windows can be 0 line high.

set autochdir " Automatically use current file's directory as the working directory. 

set foldenable  " Open all folds while not set.
"set foldmethod=syntax
"set foldmethod=indent

"set foldignore  " Characters used for "indent" folding.
"set foldmarker  " Defined markers used for "marker" folding.
"set foldmethod  " Name of the current folding method.
"set foldminlines " Minimum number of screen lines for a fold to be displayed closed.
"set foldnestmax  " Maximum nesting for "indent" and "syntax" folding.
"set foldopen    " Which kinds of commands open closed folds.
"set foldclose   " When the folds not under the cursor are closed.

set noeb vb t_vb=           " No annoying sounds on errors.
filetype plugin indent on   " Turn on file type detection.
set lazyredraw              " Don't redraw while executing macros.

set hidden        " Handle multiple buffers better.

set wildmenu     " Enhanced command line completion.
set wildmode=list:longest " Complete files like a shell.
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.py.class,*.class

if &term == "screen-256color"
    set t_RV=[>c
endif

augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source % " Automatically source the vimrc file.
augroup END

autocmd FileType css setlocal foldmethod=indent shiftwidth=2 tabstop=2 "Automatic fold settings for specific files
autocmd BufRead,BufWritePre *.html normal gg=G  "Automatically format indent html file

" Search with Very magic Regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Disable Arrow Keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

function! InsertTabWrapper()
  " Multipurpose Tab key
  " Indent if we're at the beginning of a line.Else do tab completion.
  let col = col(".") - 1
  if !col || getline(".")[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<C-n>"
endfunction

imap <Tab> <C-n>
imap <S-Tab> <C-p>
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-p>

let mapleader = " "
map <Leader>w :w<CR>
map <Leader><space> :noh<cr> " Search Highlight Removal.

map <Leader>x :call CompileRun()<CR>
func! CompileRun()
    exec "w"
if &filetype == 'c'
    exec "!clear && g++ -Wall % -o %< && ./%<"
elseif &filetype == 'cpp'
    exec "!clear && g++ -Wall % -o %< && ./%<"
elseif &filetype == 'sh'
    exec "!clear && bash %"
elseif &filetype == 'python'
    exec "!clear && python3 %"
elseif &filetype == 'javascript'
    exec "!clear && node %"
elseif &filetype == 'go'
    exec "!clear && go build %< && go run %"
endif
endfunc
