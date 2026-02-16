--style
vim.g.netrw_banner = 0  -- no banner
vim.g.netrw_liststyle = 0  -- alternate with "i" on netrw. [3] tree view like NERDTree

-- Open files in 0: actual window, 1: horizontal, 2: vertical, 3: new tab, 4: previous window
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1  -- [1] open file on the right
vim.g.netrw_winsize = 25  -- [25] netrw width
vim.g.netrw_list_hide = '^%.%.*/$,^%..*$'  -- hide hidden files. Change mode "gh", alternate "a"

-- keymaps open netrw
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>', { desc = "Netrw Vertical Split" })
vim.keymap.set('n', '<leader>E', ':Sexplore<CR>', { desc = "Netrw Horizontal Split" })

-- close netrw buffer with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true, nowait = true })
  end,
})

