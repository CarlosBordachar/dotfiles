-- enable syntax processing
vim.cmd("syntax on")

-- enable line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- show the status line at the bottom
vim.opt.laststatus = 3

-- find recursively in sub-directories
vim.opt.path:append("**")

-- allow backspacing over everything (indentation, EOL, and beginning)
vim.opt.backspace = { "indent", "eol", "start" }

-- allow auto-hiding of edited buffers without save
vim.opt.hidden = true

-- disable audible bell
vim.opt.errorbells = false
vim.opt.visualbell = true

-- enable mouse mode (scrolling, selection, etc)
vim.opt.mouse:append("a")

-- search behavior
vim.opt.hlsearch = true  -- highlight search
vim.opt.incsearch = true  -- incremental search (as string is being typed)
vim.opt.wrapscan = true  -- begin search from top of the file when nothing is found
vim.opt.ignorecase = true  -- ignore case in search by default
vim.opt.smartcase = true  -- make search case sensitive if an uppercase is entered

-- copy indent from current line when starting a new line
vim.opt.autoindent = true
vim.opt.cindent = true  -- uncomment if working with C/C++

-- show tittle window
vim.opt.title = true

-- show command in bottom bar
vim.opt.showcmd = true
--vim.opt.cmdheight = 0

-- highlight
vim.opt.cursorline = true  -- highlight current line
--vim.opt.cursorlineopt = "number"  -- highlight only number, not line/row
--vim.opt.cursorlineopt = "screenline"  -- highlight only line/row, not number
vim.opt.colorcolumn = "80"  -- highlight column 80


-- visual autocomplete for command menu
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"  -- command-line completion mode

-- number of suggestions
vim.opt.pumheight = 10  -- limit LSP completion items length to 10

-- split windows
vim.opt.splitbelow = true  -- open new vertical split bottom
vim.opt.splitright = true  -- open new horizontal split right
vim.opt.splitkeep = "screen"  -- keep the text on the same screen line

-- delays (used by LSP, autosave, etc)
vim.opt.updatetime = 350

-- always show the singcolumn (for LSP, git, etc)
vim.opt.signcolumn = "yes"

-- minimal scroll off
vim.opt.scrolloff = 4  -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8  -- minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.sidescroll = 2  -- make scrolling better, instead of wrap we scroll horizontally with the cursor

-- text wrapping
vim.opt.wrap = false  -- don't wrap lines
vim.opt.breakindent = true  -- line wrapping preserves indentation
vim.opt.linebreak = true  -- primarily to prevent wrapping within words
vim.opt.whichwrap:append('<>[]hl')  -- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line

-- width of a tab
vim.opt.expandtab = true  -- use number of spaces to insert a <Tab>
vim.opt.shiftwidth = 4  -- when we hit tab it moves 4 spaces
vim.opt.tabstop = 4  -- setting auto indent to 4 spaces
vim.opt.softtabstop = 4  -- option so make backspace delete entire tab
vim.opt.smarttab = true  -- make tab behaviour smarter
vim.opt.shiftround = true  -- Rounds the indent spacing to the next multiple of shiftwidth EG. If you have something 3 spaces in and hit < it will move 2 or 4 spaces depending on shiftwidth and line up
vim.opt.list = true  -- show some invisible characters (tabs, ...

-- highlight matching [{()}]
vim.opt.showmatch = true
vim.opt.matchpairs:append({ '<:>,「:」,『:』,【:】,“:”,‘:’,《:》' })  -- Characters that form pairs. The % command jumps from one to the other

-- clipboard
--vim.opt.clipboard = 'unnamedplus' -- share system clipboard but also retain nvim clipboard (see += compared

-- modes
vim.opt.virtualedit = "block"  -- allow cursor to move where the is no text in visual block mode

--NOTE: ripgrep
vim.opt.grepprg = 'rg --vimgrep'
