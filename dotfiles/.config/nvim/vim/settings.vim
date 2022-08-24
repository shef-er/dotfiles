"---------------------------------------
"   NeoVim Defaults (compared to vim)
"---------------------------------------
"  Syntax highlighting is enabled by default
"  ":filetype plugin indent on" is enabled by default

"  'autoindent' is enabled
"  'autoread' is enabled
"  'background' defaults to "dark" (unless set automatically by the terminal/UI)
"  'backspace' defaults to "indent,eol,start"
"  'backupdir' defaults to .,~/.local/share/nvim/backup (|xdg|)
"  'belloff' defaults to "all"
"  'compatible' is always disabled
"  'complete' excludes "i"
"  'cscopeverbose' is enabled
"  'directory' defaults to ~/.local/share/nvim/swap/ (|xdg|), auto-created
"  'display' defaults to "lastline,msgsep"
"  'encoding' is UTF-8 (cf. 'fileencoding' for file-content encoding)
"  'fillchars' defaults (in effect) to "vert:│,fold:·,sep:│"
"  'formatoptions' defaults to "tcqj"
"  'fsync' is disabled
"  'history' defaults to 10000 (the maximum)
"  'hlsearch' is enabled
"  'incsearch' is enabled
"  'langnoremap' is enabled
"  'langremap' is disabled
"  'laststatus' defaults to 2 (statusline is always shown)
"  'listchars' defaults to "tab:> ,trail:-,nbsp:+"
"  'nrformats' defaults to "bin,hex"
"  'ruler' is enabled
"  'sessionoptions' excludes "options"
"  'shortmess' includes "F", excludes "S"
"  'showcmd' is enabled
"  'sidescroll' defaults to 1
"  'smarttab' is enabled
"  'startofline' is disabled
"  'tabpagemax' defaults to 50
"  'tags' defaults to "./tags;,tags"
"  'ttimeoutlen' defaults to 50
"  'ttyfast' is always set
"  'undodir' defaults to ~/.local/share/nvim/undo (|xdg|), auto-created
"  'viminfo' includes "!"
"  'wildmenu' is enabled
"  'wildoptions' defaults to "pum,tagfile"


"---------------------------------------
"   General
"---------------------------------------
" Character encodings considered when starting to edit an existing file
  set fileencodings=utf-8,cp1251
" Always add lf in the end of file
  set fileformat=unix


"---------------------------------------
"   Interface
"---------------------------------------
  set mouse=a
  set synmaxcol=128
  "syntax sync minlines=256

" Colorscheme
  set termguicolors
  colorscheme bubblegum-256-light

  set completeopt=longest,menuone

" Set completion mode
" When more than one match, list all matches and complete first match
" Then complete the next full match
  set wildmode=list:longest,full

" Ignore following files when completing file/directory names
  " Version control
  set wildignore+=*/.git,*/.git/*,*/.hg,*/.hg/*,*/.svn,*/.svn/*
  " OS X
  set wildignore+=*.DS_Store*
  " C/C++ object file
  set wildignore+=*.o
  " Python and ruby byte code
  set wildignore+=*.rbc,.rbx,*.scssc,*.sassc,.sass-cache,*.pyc,*.gem
  " Binary images
  set wildignore+=*.jpg,*.jpeg,*.tiff,*.bmp,*.ico,*.gif,*.png,*.psd,*.pdf
  " Archives
  set wildignore+=*.tar.gz,*.tar.xz,*.zip,*.7z
  " Temporary files
  set wildignore+=*.swp,*~
  " Cache files
  set wildignore+=*/cache/*,*/__pycache__/*
  " Build files
  set wildignore+=*/compiled/*,*/dist/*,*/_site/*

" Set title of the window to filename
  set title

" Show (partial) command in the last line of the screen
  set showcmd

  " Precede each line with its line number
  set number

  " Show the line and column number of the cursor position
  set ruler

  " Comma separated list of highlighted screen columns
  set colorcolumn=80

" Fixes the freezes when cursorline or cursorcolumn enabled
  set lazyredraw

  "set cursorline
  "set cursorcolumn

" Minimal number of lines to scroll when cursor gets off the screen
  "set scrolljump=10

" Typewriter mode = keep current line in the center
  "set scrolloff=999

" Display invisible characters
  set list
  set listchars=tab:→\ ,trail:·,extends:»,precedes:«,nbsp:×
  "set listchars+=eol:¬

  " Characters to fill the statuslines and vertical separators
  set fillchars+=vert:\|

" Do not wrap long lines
  "set nowrap

" Don't break words when wrapping
  set linebreak
" Show ↵ at the beginning of wrapped lines
  if has("linebreak")
      let &sbr = nr2char(8629).' '
  endif

" Do smart indenting when starting a new line
  set smartindent

" Number of spaces to use for each step of (auto)indent
  set shiftwidth=2

" Use spaces instead of tab
  set expandtab

" Number of spaces that a tab counts for
  set tabstop=2

" Number of spaces that a tab counts for while performing editing operations
  set softtabstop=2

" Number of colors
  set t_Co=256

" Splitting a window will put the new window below or right of the current one
  set splitbelow
  set splitright

" Don't show the intro message starting Vim
  "set shortmess+=I

" Edit several files in the same time without having to save them
  set hidden

" Vim will change the current working directory whenever you open a file
  set autochdir

" No beeps, no flashes
  set noerrorbells visualbell t_vb=

" List of directories which will be searched when using :find, gf, etc.
" Search relative to the directory of the current file
" Search in the current directory
" Search downwards in a directory tree
  set path=.,,**


"---------------------------------------
"   Status line  ( +statusline )
"---------------------------------------
" Custom folding function
  function! FileSize()
      let bytes = getfsize(expand("%:p"))
      if bytes <= 0
          return ""
      endif
      if bytes < 1024
          return bytes . "B"
      else
          return (bytes / 1024) . "K"
      endif
  endfunction

  function! CurDir()
      return expand('%:p:~')
  endfunction

" Buffer number
  set statusline=\ %n:

" File name, modifed and read-only flags
  set statusline+=\ %t%m%r

" Move indicators to the right
  set statusline+=%=

" File type ( +autocmd feature )
  set statusline+=\ \ %Y

" File encoding and file format
  set statusline+=\ \ %{&enc}[%{&ff}]

" File size
  "set statusline+=\ \ %{FileSize()}

" Percentage through file in lines
  set statusline+=\ %3p%%

" Column and line numbers under cursor
  set statusline+=\ \ %3l:%3c

" Truncate here if line is too long
  set statusline+=\ %<


"---------------------------------------
"   Folding  ( +folding )
"---------------------------------------
  " za = toggle current fold
  " zR = open all folds
  " zM = close all folds
  " From https://github.com/sjl/dotfiles/blob/master/vim/.vimrc
  "function! MyFoldText()
  "    let line = getline(v:foldstart)
  "    let nucolwidth = &fdc + &number * &numberwidth
  "    let windowwidth = winwidth(0) - nucolwidth - 3
  "    let foldedlinecount = v:foldend - v:foldstart
  "    " expand tabs into spaces
  "    let onetab = strpart(' ', 0, &tabstop)
  "    let line = substitute(line, '\t', onetab, 'g')
  "    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  "    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  "    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  "endfunction
  "set foldtext=MyFoldText()

  " Lines with equal indent form a fold
  set foldmethod=indent
  "set foldmethod=syntax
" Maximum nesting of folds
  set foldnestmax=10
" All folds are open
  set nofoldenable
" Folds with a higher level will be closed
  set foldlevel=1
" Remove the extrafills --------
  set fillchars="fold: "


"---------------------------------------
"   Search
"---------------------------------------
" Ignore case in search patterns
  "set ignorecase
" Override the 'ignorecase' if the search pattern contains upper case characters
  "set smartcase

" For regular expressions turn magic on
  set magic


"---------------------------------------
"   Environment
"---------------------------------------
" Don't create backups and swap files
  set nobackup
  "set backupdir=~/.local/share/nvim/backup

  set noswapfile
  "set directory=~/.local/share/nvim/swap
  "
  set noundofile
  "set undodir=~/.local/share/nvim/undo


" Same clipboard with the system
  set clipboard=unnamed,unnamedplus

" Remaping russian symbols
  set keymap=russian-jcukenwin
  set iminsert=0
  set imsearch=0

" Russian spellcheck with 'ё'
  set spelllang=ru_yo,en_us

" Config autoreload
  "autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

"---------------------------------------
"   File specific settings
"---------------------------------------
  autocmd BufNewFile *.txt setlocal wrap
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

