-- Todo lists like VSCode's Todo+
-- Active in files named: todo.md, TODO.md, todo, *.todo, *.todo.md
-- Saved as normal Markdown checkboxes (- [ ] / - [x]) so they still render on GitHub.
-- Turn a buffer into a todo list without needing a file (works on [No Name] buffers)
local function todo_here(new_buffer)
  return function()
    if new_buffer then
      vim.cmd("enew")
    end
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].filetype ~= "markdown" then
      vim.bo[buf].filetype = "markdown" -- also loads checkmate
    end
    -- checkmate only auto-activates for named todo files, so switch it on by hand
    -- (deferred so the plugin has finished starting up)
    vim.schedule(function()
      local B = require("checkmate.buffer")
      if not B.is_active(buf) then
        require("checkmate.commands").setup(buf)
        B.get(buf):setup()
      end
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      if #lines == 1 and lines[1] == "" then
        require("checkmate").create()
      end
    end)
  end
end

vim.api.nvim_create_user_command("Todo", function() todo_here(true)() end, { desc = "New unsaved todo list" })

return {
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    cmd = "Checkmate",
    keys = {
      { "<D-t>", todo_here(true), desc = "New unsaved todo list" },
      { "<leader>TN", todo_here(true), desc = "New unsaved todo list" },
      { "<leader>TH", todo_here(false), desc = "Make this buffer a todo list" },
    },
    opts = {
      todo_states = {
        unchecked = { marker = "☐", order = 1 },
        checked = { marker = "✔", order = 2 },
        cancelled = { marker = "✘", markdown = "~", type = "complete", order = 3 },
      },
      keys = {
        -- Todo+-style shortcuts (Option key)
        ["<M-CR>"] = { rhs = "<cmd>Checkmate create<CR>", desc = "New todo", modes = { "n", "v" } },
        ["<M-d>"] = {
          rhs = function() require("checkmate").toggle_metadata("done") end,
          desc = "Done (with timestamp)",
          modes = { "n", "v" },
        },
        ["<M-c>"] = {
          rhs = function() require("checkmate").toggle("cancelled") end,
          desc = "Cancel todo",
          modes = { "n", "v" },
        },
        ["<M-s>"] = {
          rhs = function() require("checkmate").toggle_metadata("started") end,
          desc = "Started (with timestamp)",
          modes = { "n", "v" },
        },
        -- Cmd+Enter in Neovide toggles done quickly (no timestamp)
        ["<D-CR>"] = { rhs = "<cmd>Checkmate toggle<CR>", desc = "Toggle todo", modes = { "n", "v" } },
        -- Space-based keys (also shown in the Space menu)
        ["<leader>Tt"] = { rhs = "<cmd>Checkmate toggle<CR>", desc = "Toggle todo", modes = { "n", "v" } },
        ["<leader>Tn"] = { rhs = "<cmd>Checkmate create<CR>", desc = "New todo", modes = { "n", "v" } },
        ["<leader>Ta"] = { rhs = "<cmd>Checkmate archive<CR>", desc = "Archive done todos", modes = { "n" } },
        ["<leader>Tf"] = { rhs = "<cmd>Checkmate select_todo<CR>", desc = "Find a todo", modes = { "n" } },
      },
    },
  },
  { "folke/which-key.nvim", opts = { spec = { { "<leader>T", group = "todo" } } } },
}
