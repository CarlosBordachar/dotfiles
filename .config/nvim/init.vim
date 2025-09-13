"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic editing config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filetype off
syntax on                       " enable syntax processing
set showmatch                   " highlight matching [{()}]
set number                      " number lines
set relativenumber              " relative number lines from current line
set laststatus=2                " Show the status line at the bottom
set path+=**
set backspace=indent,eol,start  " allow backspacing over everything
set hidden                      " allow auto-hiding of edited buffers
set noerrorbells visualbell t_vb= " disable audible bell
set ignorecase                  " ignore case in searches by default
set smartcase                   " but make it case sensitive if an uppercase is entered
set mouse+=a                    " enable mouse mode (scrolling, selection, etc)
set hlsearch                    " highlight search
set incsearch                   " incremental search (as string is being typed)
set autoindent                 	" copy indent from current line when starting a new line
"set cindent                     " enables automatic C program indenting.
set title
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
set splitbelow                  " open new vertical split bottom
set splitright                  " open new horizontal splits right
set colorcolumn=80              " highlight column 80
set updatetime=350              " delays
set signcolumn=yes              " Always show the signcolumn
set pumheight=10                " number of suggestions
set scrolloff=4                 " minimal number of screen lines to keep above and below the cursor
set sidescrolloff=8             " minimal number of screen columns either side of cursor if wrap is `false`
