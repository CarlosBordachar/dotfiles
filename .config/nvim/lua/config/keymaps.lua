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

-- Enter Command Mode
map("n", "<leader><leader>", ":", { desc = "Enter Command Mode" })

-- Turn Off Search Matches with Doucle <Esc>
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { desc = "Turn Off Search Matches" })

-- Move Lines (from LazyVim)
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Keep selection when shifting
map("v", ">", ">gv", { desc = "Shift Right" })
map("v", "<", "<gv", { desc = "Shift Left" })

-- Move to Start/End of line with Home Row Keys
map({ "n", "v" }, "gh", "_", { desc = "Move to Start of Line" })
map({ "n", "v" }, "gl", "$", { desc = "Move to End of Line" })

-- Send Search Results to the Quickfix List
map("n", "g/", ":vimgrep /<C-R>//j %<CR>|:cw<CR>", { desc = "Send Search Results to the Quickfix List" })

-- Visual Select Last Yank
map("n", "g<C-v>", "`[v`]", { desc = "Visual Select Last Yank" })

-- Select to end of line
map("n", "<leader>v", "vg_", { desc = "Select to End of Line" })

-- Search and Replace Word Under Cursor
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "Search and Replace Word Under Cursor" })

-- Toggle Diff Mode Side-by-Side
local function toggle_diff()
   if vim.wo.diff then
      vim.cmd("diffoff!")
   else
      vim.cmd("windo diffthis")
   end
end

map("n", "<leader>dd", toggle_diff, { desc = "Toggle Diff Mode Side-by-Side" })

---- Surround
map("v", "s{", "<esc>`>a}<esc>`<i{<esc>", { desc = "Surround with {} in visual mode" })
map("v", "s[", "<esc>`>a]<esc>`<i[<esc>", { desc = "Surround with [] in visual mode" })
map("v", "s(", "<esc>`>a)<esc>`<i(<esc>", { desc = "Surround with () in visual mode" })
map("v", "s'", "<esc>`>a'<esc>`<i'<esc>", { desc = "Surround with '' in visual mode" })
map("v", 's"', '<esc>`>a"<esc>`<i"<esc>', { desc = 'Surround with "" in visual mode' })
map("v", "s<", "<esc>`>a><esc>`<i<<esc>", { desc = "Surround with <> in visual mode" })

