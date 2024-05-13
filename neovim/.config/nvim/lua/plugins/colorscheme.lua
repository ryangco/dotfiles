return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('kanagawa').setup {
        commentStyle = { italic = false },
        statementStyle = { bold = false },
        colors = {
          palette = {
            sumiInk3 = '#000000',
            sumiInk4 = '#000000',
            dragonBlack3 = '#000000',
            dragonBlack4 = '#000000',
          },
        },
      }
      vim.cmd 'colorscheme kanagawa'
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      style = 'night',
      on_colors = function(colors)
        colors.bg = '#000000'
        colors.bg_dark = '#000000'
      end,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        -- functions = { italic = false },
        variables = { italic = false },
      },
    },
  },
}
