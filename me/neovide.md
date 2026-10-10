# Neovide

Install `neovide-app` (Homebrew cask). macOS only for the Cmd keys.

All its settings live in the Neovim config (`me/nvim/lua/config/options.lua` and `keymaps.lua`), applied when `vim.g.neovide` is set:
- Font: JetBrains Mono 15, extra line spacing 16px, padding 18 top and 6 at the sides.
- Subtle motion only: short scroll and cursor animations, no cursor trail or effects, 120Hz.
- Follows macOS light/dark mode; left Option key works as Meta; remembers window size; asks before quitting.
- Mac shortcuts: Cmd+S/C/V/A, Cmd+P find files, Cmd+Shift+F search the project, Cmd+B tree, Cmd+W close tab, Cmd +/-/0 zoom.
