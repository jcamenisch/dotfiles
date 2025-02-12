-- Adds git related signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns` to understand what the configuration keys do

vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<Enter>', { desc = 'git blame' })

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_formatter = '<abbrev_sha> <author> <author_time:%m/%d/%y> <summary>',
  },
}
