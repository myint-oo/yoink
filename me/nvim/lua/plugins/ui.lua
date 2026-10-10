-- Switch tabs (buffers) reliably, even when focus is in the file tree or outline.
-- Skips the empty placeholder buffer left over from opening a folder.
local function cycle(dir)
  return function()
    if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "Outline" then
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
        if ft ~= "neo-tree" and ft ~= "Outline" and vim.api.nvim_win_get_config(w).relative == "" then
          vim.api.nvim_set_current_win(w)
          break
        end
      end
    end
    local bufs = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted and vim.api.nvim_buf_get_name(b) ~= ""
    end, vim.api.nvim_list_bufs())
    if #bufs == 0 then return end
    local cur = vim.api.nvim_get_current_buf()
    local idx = 0
    for i, b in ipairs(bufs) do
      if b == cur then idx = i end
    end
    if idx == 0 then idx = dir > 0 and 0 or 1 end
    vim.api.nvim_set_current_buf(bufs[(idx - 1 + dir) % #bufs + 1])
  end
end

return {
  -- Default theme: Tokyo Night (night). Try others live with <Space>uC.
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      styles = { comments = { italic = true }, keywords = { italic = false } },
      on_highlights = function(hl, c)
        -- flat, borderless-looking popups and pickers
        hl.FloatBorder = { fg = c.bg_dark, bg = c.bg_dark }
        hl.WinSeparator = { fg = c.bg_highlight }
      end,
    },
  },
  -- Light/dark follows macOS appearance: GitHub Light by day, Tokyo Night by night
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local themes = { light = "github_light_default", dark = "tokyonight-night" }
        local function apply()
          local want = themes[vim.o.background] or themes.dark
          if vim.g.colors_name ~= want then
            vim.cmd.colorscheme(want)
          end
        end
        apply()
        vim.api.nvim_create_autocmd("OptionSet", {
          pattern = "background",
          callback = function() vim.schedule(apply) end,
        })
        -- OptionSet doesn't fire during startup, when Neovide sets the initial mode
        vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
          callback = function() vim.schedule(apply) end,
        })
      end,
    },
  },

  -- Extra themes to preview with <Space>uC
  { "Mofiqul/vscode.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  { "projekt0n/github-nvim-theme", name = "github-theme", lazy = true, priority = 1000 },
  { "sainnhe/gruvbox-material", lazy = true },

  -- VSCode-style file tree on the left
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "left",
        width = 32,
        mappings = {
          ["<LeftRelease>"] = "open", -- single click opens, like VSCode
          ["H"] = cycle(-1), -- prev tab (instead of toggle hidden files)
          ["L"] = cycle(1), -- next tab
          -- search only inside the folder under the cursor
          ["F"] = {
            function(state)
              local node = state.tree:get_node()
              local dir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
              Snacks.picker.files({ cwd = dir })
            end,
            desc = "Find files in this folder",
          },
          ["<C-f>"] = {
            function(state)
              local node = state.tree:get_node()
              local dir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
              Snacks.picker.grep({ cwd = dir })
            end,
            desc = "Search text in this folder",
          },
        },
      },
      filesystem = {
        filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        indent = { with_expanders = true },
        git_status = { symbols = { unstaged = "●", staged = "✓", untracked = "?" } },
      },
    },
  },

  -- VSCode-style tabs: accent bar on the active tab, thin dividers, roomy labels
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<S-h>", cycle(-1), desc = "Prev Tab" },
      { "<S-l>", cycle(1), desc = "Next Tab" },
      { "[b", cycle(-1), desc = "Prev Tab" },
      { "]b", cycle(1), desc = "Next Tab" },
      { "<C-Tab>", cycle(1), desc = "Next Tab" },
      { "<C-S-Tab>", cycle(-1), desc = "Prev Tab" },
    },
    opts = {
      options = {
        separator_style = "thin",
        indicator = { style = "icon", icon = "▎" },
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
        tab_size = 26,
        max_name_length = 30,
        diagnostics = false,
        offsets = {
          { filetype = "neo-tree", text = "  EXPLORER", text_align = "left", highlight = "Directory", separator = true },
        },
      },
      highlights = {
        buffer_selected = { bold = true, italic = false },
        indicator_selected = { fg = { attribute = "fg", highlight = "Function" } },
      },
    },
  },
}
