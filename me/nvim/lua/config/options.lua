-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.relativenumber = true
opt.scrolloff = 8
opt.wrap = true -- wrap long lines, so there's never horizontal scrolling
opt.linebreak = true -- wrap at word boundaries
opt.breakindent = true -- wrapped lines keep their indentation
opt.mousescroll = "ver:3,hor:0" -- disable horizontal trackpad/mouse scrolling
opt.cursorline = true
opt.mouse = "a" -- click, scroll and select with the mouse like an IDE
opt.clipboard = "unnamedplus" -- share clipboard with macOS
opt.fillchars = { eob = " " }
vim.g.lazyvim_php_lsp = "intelephense" -- faster than phpactor on large Symfony codebases

-- Neovide (GUI) settings — only apply when running inside Neovide
if vim.g.neovide then
  -- JetBrains Mono for text, Nerd Font symbols as fallback for icons
  vim.o.guifont = "JetBrains Mono,Symbols Nerd Font Mono:h15:w1.5:#e-subpixelantialias:#h-none"
  vim.opt.linespace = 16 -- extra line height in pixels

  vim.g.neovide_padding_top = 18
  vim.g.neovide_padding_left = 6
  vim.g.neovide_padding_right = 6
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_window_blurred = false
  vim.g.neovide_floating_shadow = false

  -- subtle motion only
  vim.g.neovide_scroll_animation_length = 0.15
  vim.g.neovide_cursor_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_refresh_rate = 120

  vim.g.neovide_theme = "auto" -- follow macOS light/dark mode
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_confirm_quit = true
end

-- Spacing: gap between line numbers and code
vim.opt.numberwidth = 4
vim.opt.statuscolumn = [[%!v:lua.LazyVim.statuscolumn() .. '   ']]

-- Treat todo files without a .md extension as markdown (so the todo plugin works)
vim.filetype.add({
  filename = { ["todo"] = "markdown", ["TODO"] = "markdown", ["Todo"] = "markdown" },
  extension = { todo = "markdown" },
})
