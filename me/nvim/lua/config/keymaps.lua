-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- VSCode-style shortcuts (Cmd keys reach Neovim only if your terminal forwards them; these Ctrl variants always work)
map("n", "<C-p>", LazyVim.pick("files"), { desc = "Find files (like Cmd+P)" })
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree (like Cmd+B)" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- macOS Cmd shortcuts inside Neovide
if vim.g.neovide then
  map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
  map("v", "<D-c>", '"+y', { desc = "Copy" })
  map({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste" })
  map({ "i", "c" }, "<D-v>", "<C-r>+", { desc = "Paste" })
  map("t", "<D-v>", '<C-\\><C-n>"+pi', { desc = "Paste" })
  map("n", "<D-a>", "ggVG", { desc = "Select all" })
  map("n", "<D-p>", LazyVim.pick("files"), { desc = "Find files" })
  map("n", "<D-S-f>", LazyVim.pick("live_grep"), { desc = "Search in project" })
  map("n", "<D-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
  map("n", "<D-w>", function() Snacks.bufdelete() end, { desc = "Close tab" })

  -- Cmd +/-/0 to zoom
  vim.g.neovide_scale_factor = 1.0
  local function zoom(d) vim.g.neovide_scale_factor = d == 0 and 1.0 or vim.g.neovide_scale_factor * d end
  map("n", "<D-=>", function() zoom(1.1) end, { desc = "Zoom in" })
  map("n", "<D-->", function() zoom(1 / 1.1) end, { desc = "Zoom out" })
  map("n", "<D-0>", function() zoom(0) end, { desc = "Reset zoom" })
end

-- No horizontal scrolling anywhere
for _, k in ipairs({ "<ScrollWheelLeft>", "<ScrollWheelRight>", "<S-ScrollWheelUp>", "<S-ScrollWheelDown>" }) do
  map({ "n", "i", "v", "x" }, k, "<Nop>")
end
