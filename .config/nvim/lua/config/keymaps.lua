local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }

   if opts then
      if opts["desc"] then
         opts["desc"] = "keymaps.lua: " .. opts["desc"]
      end
      options = vim.tbl_extend("force", options, opts)
   end
   
   vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "  -- space
vim.g.maplocalleader = " "  -- space

-- Move Lines (from LazyVim)
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

