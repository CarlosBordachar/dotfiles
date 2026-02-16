-- only highlight when searching
--vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--      local cmd = vim.v.event.cmdtype
--      if cmd == "/" or cmd == "?" then
--         vim.opt.hlsearch = true
--      end
--   end,
--})
--vim.api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--      local cmd = vim.v.event.cmdtype
--      if cmd == "/" or cmd == "?" then
--         vim.opt.hlsearch = false
--      end
--   end,
--})

-- Highlight when yanking
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#f9e2af", fg = "#000000" })
vim.api.nvim_create_autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank({
         higroup = "YankHighlight",
         timeout = 200,
      })
   end,
})

-- turn on spell check for markdown and text file
vim.api.nvim_create_augroup("SpellCheck", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   group = "SpellCheck",
   pattern = { "markdown", "text", "txt", "gitcommit", "mail" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

-- turn on column color for 50/72 rule commit message
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "gitcommit" },
   callback = function()
      vim.opt_local.colorcolumn = { 50, 72 }
      vim.opt_local.textwidth = 72
      --vim.opt_local.formatoptions:append("t") -- auto-wrap by textwidth
   end,
})

-- set tab to 3 space when entering a buffer with .lua file
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.lua" },
   callback = function()
      vim.opt_local.shiftwidth = 3
      vim.opt_local.tabstop = 3
      vim.opt_local.softtabstop = 3
   end
})

