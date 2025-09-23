-- Enable syntax processing
-- Activar resaltado de sintaxis
vim.cmd("syntax on")

-- Highlight matching [{()}]
-- Mostrar coincidencias de paréntesis, llaves, corchetes
vim.opt.showmatch = true

-- Enable line number and relative line number
-- Mostrar números de línea (relativos)
vim.opt.number = true
vim.opt.relativenumber = true

-- Show the status line at the bottom
-- Mostrar la barra de estado
vim.opt.laststatus = 2

-- Buscar recursivamente en subdirectorios (equivalente a set path+=**)
vim.opt.path:append("**")

-- Allow backspacing over everything
-- Permitir retroceder sobre indentación, EOL y el comienzo
vim.opt.backspace = { "indent", "eol", "start" }

-- Allow auto-hiding of edited buffers
-- Permitir ocultar buffers sin guardar
vim.opt.hidden = true

-- Disable audible bell
-- Desactivar sonido del 'bell' y usar visual bell
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Ignore case in searches by default,
-- but make it case sensitive if an uppercase is entered
-- Búsqueda insensible a mayúsculas, pero sensible si hay mayúsculas
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable mouse mode (scrolling, selection, etc)
-- Habilitar el ratón (para scroll, resize, etc.)
vim.opt.mouse:append("a")

-- Highlight search
-- Resaltar todas las coincidencias de búsqueda
vim.opt.hlsearch = true

-- Incremental search (as string is being typed)
-- Búsqueda incremental mientras escribes
vim.opt.incsearch = true

-- Copy indent from current line when starting a new line
-- Autoindentar nuevas líneas
vim.opt.autoindent = true
-- vim.opt.cindent = true  -- Descomentar si se trabaja con C/C++

-- Mostrar el título de la ventana
vim.opt.title = true

-- Show command in bottom bar
-- Mostrar el comando actual en la barra inferior
vim.opt.showcmd = true

-- Highlight current line
-- Resaltar la línea actual
vim.opt.cursorline = true

-- Visual autocomplete for command menu
-- Menú visual para autocompletar comandos
vim.opt.wildmenu = true

-- Open new vertical split bottom and new horizontal splits right
-- Abrir divisiones (splits) abajo y a la derecha por defecto
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight column 80
-- Resaltar la columna 80 (útil para límites de código)
vim.opt.colorcolumn = "80"

-- Delays (used by LSP, autosave, etc)
-- Tiempo de actualización (usado por LSP, autoguardado, etc.)
vim.opt.updatetime = 350

-- Always show the singcolumn
-- Mostrar siempre la columna de signos (para LSP, git, etc.)
vim.opt.signcolumn = "yes"

-- Number of suggestions
-- Límite de sugerencias en el menú de autocompletado
vim.opt.pumheight = 10

-- Minimal number of screen lines to keep above and below the cursor
-- Mantener 4 líneas alrededor del cursor al hacer scroll
vim.opt.scrolloff = 4

-- Minimal number of screen columns either side of cursor if wrap is `false`
-- Mantener 8 columnas a los lados del cursor
vim.opt.sidescrolloff = 8

-- width of a tab
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true
