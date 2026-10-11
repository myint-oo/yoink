return {
  -- No markdownlint warnings (MD060 table style etc.) — these files are for reading
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { markdown = {} } },
  },
  -- Render markdown nicely inside the editor (headings, tables, code blocks, checkboxes, links).
  -- Rendered in normal mode; switches to raw text while you're typing in insert mode.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- todo files are drawn by checkmate.nvim instead (see plugins/todo.lua)
      ignore = function(buf)
        local name = vim.fs.basename(vim.api.nvim_buf_get_name(buf)):lower()
        return name == "todo" or name == "todo.md" or name:match("%.todo$") ~= nil or name:match("%.todo%.md$") ~= nil
      end,
      -- stay rendered while reading, moving, selecting (v/V/Ctrl-v) and running commands;
      -- only switch to raw text when you start typing (insert/replace mode)
      render_modes = { "n", "no", "c", "t", "v", "V", "\22", "s", "S" },
      anti_conceal = { enabled = false }, -- keep the cursor line rendered too, for reading
      heading = {
        sign = false,
        width = "full",
        left_pad = 1,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = { sign = false, width = "block", left_pad = 2, right_pad = 4, border = "thick" },
      bullet = { icons = { "●", "○", "◆", "◇" } },
      checkbox = { enabled = true },
      pipe_table = { style = "full", cell = "padded" },
      quote = { repeat_linebreak = true },
      link = { enabled = true },
    },
  },
}
