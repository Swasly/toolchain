return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- make fzf faster
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      -- load fzf-native extension
      require('telescope').load_extension('fzf')

      -- fzf files under cwd:
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files, { desc = "telescope search cwd" })

      -- fzf help:
      vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "telescope search nvim help" })

      -- fzf files in the neovim config directory:
      vim.keymap.set("n", "<space>en", function()
          require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath("config")
          }
        end,
        { desc = "telescope search nvim config" })

      -- fzf files in neovim lazy plugins dir
      vim.keymap.set("n", "<space>ep", function()
          require('telescope.builtin').find_files {
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          }
        end,
        { desc = "telescope search nvim plugins" })

      -- custom extensions found at $XDG_CONFIG_HOME/nvim/lua/config/telescope/*.lua
      require "config.telescope.multigrep".setup()
      require "config.telescope.zebugrep".setup()
      require "config.telescope.velocegrep".setup()

    end,
  },
}
