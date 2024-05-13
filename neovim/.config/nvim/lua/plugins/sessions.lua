return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      auto_session_use_git_branch = false,
      auto_session_enable_last_session = false,
      -- ⚠️ This will only work if Telescope.nvim is installed
      -- The following are already the default values, no need to provide them if these are already the settings you want.
      session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
      vim.keymap.set('n', '<leader>ll', require('auto-session.session-lens').search_session, { desc = '[L]ist Sessions', noremap = true }),
      vim.keymap.set('n', '<leader>lc', '<CMD>SessionDelete<CR>', { desc = '[C]lose Current Session', noremap = true }),
    }
  end,
}
