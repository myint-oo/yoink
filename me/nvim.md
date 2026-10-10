# Neovim

Install `neovim` (Homebrew). Runs LazyVim.

Also install what it needs (Homebrew), plus a Nerd Font (see theme.md):
- `ripgrep` and `fd`: file and text search in the pickers.
- `lazygit`: the git UI (`<Space>gg`).
- `tree-sitter-cli`: builds syntax parsers.
- `node`: Mason uses npm to install language servers (intelephense, TypeScript, and others).
- `go`: needed by the Go extra (Mason installs gopls and other Go tools with it).
- `php`: needed by the PHP extra.

Config: copy `me/nvim/` to `~/.config/nvim/` as is. On first launch lazy.nvim installs the plugins.

What it sets up, in short:
- Themes: GitHub Light when light, Tokyo Night (night) when dark, following the OS.
- VSCode-style layout: neo-tree file explorer on the left (single click opens), bufferline tabs, a file path bar above the code.
- Relative line numbers, cursorline, scrolloff 8, wrapping always on, no horizontal scrolling, system clipboard.
- Ctrl+P find files, Ctrl+B toggle the tree, Ctrl+S save; H/L or Ctrl+Tab switch tabs.
- Markdown renders in the editor, with no spellcheck or lint warnings.
- LazyVim extras for PHP (intelephense), Go, SQL, TypeScript, Docker, YAML, JSON, TOML, Markdown, Git.
- Neovide settings live in `lua/config/options.lua` and `keymaps.lua` (see neovide.md).
