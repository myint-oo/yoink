-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- A slim header line under the tabs showing the file path (like VSCode breadcrumbs),
-- which also gives breathing room between the tabs and the code
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufFilePost" }, {
  callback = function(ev)
    local win = vim.api.nvim_get_current_win()
    if vim.bo[ev.buf].buftype ~= "" or vim.api.nvim_win_get_config(win).relative ~= "" then
      return
    end
    vim.wo[win].winbar = "%#Comment#   %{expand('%:~:.')}%m"
  end,
})

-- Markdown: no spellcheck underlines when reading
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.conceallevel = 2
  end,
})

-- Set the working folder on startup so searches stay inside your project:
--   folder argument  -> that folder
--   file argument    -> the file's git project (or its folder)
--   nothing (Dock)   -> home, never the whole disk at "/"
local function set_startup_cwd()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd.cd(vim.fn.fnameescape(arg))
    elseif arg ~= "" then
      local file = vim.fn.fnamemodify(arg, ":p")
      local git = vim.fs.root(file, ".git")
      vim.cmd.cd(vim.fn.fnameescape(git or vim.fn.fnamemodify(file, ":h")))
    elseif vim.fn.getcwd() == "/" then
      vim.cmd.cd(vim.fn.fnameescape(vim.env.HOME))
    end
end
-- this file may load after startup (LazyVim defers it when no file is given)
if vim.v.vim_did_enter == 1 then
  set_startup_cwd()
else
  vim.api.nvim_create_autocmd("VimEnter", { callback = set_startup_cwd })
end

-- Keep wrapping on in every window (some plugins turn it off), so nothing scrolls sideways
vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  callback = function()
    if vim.bo.filetype ~= "neo-tree" then
      vim.wo.wrap = true
    end
  end,
})
