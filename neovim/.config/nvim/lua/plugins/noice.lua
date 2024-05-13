return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    keys = {
      vim.api.nvim_set_keymap('n', '<leader>nn', ':NoiceDismiss<CR>', { noremap = true }),
    },
    routes = {
      {
        view = 'cmdline',
        filter = { event = 'msg_showmode' },
      },
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      },
    },
    lsp = {
      progress = { enabled = false },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      -- command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true,
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
