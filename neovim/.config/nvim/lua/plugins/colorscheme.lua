return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        palette = {
          sumiInk3 = '#000000',
          sumiInk4 = '#000000',
          dragonBlack3 = '#000000',
          dragonBlack4 = '#000000',
        },
      },
    },
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
        -- comments = { italic = false },
        keywords = { italic = false },
        -- functions = { italic = false },
        variables = { italic = false },
      },
    },
  },
}
