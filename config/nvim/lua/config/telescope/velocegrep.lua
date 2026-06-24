local M = {}

M.setup = function()

      -- fzf for files related to veloce build area:
      -- DOES NOT SEARCH:
      -- - veloce.wave directory
      -- - veloce.med directory
      vim.keymap.set("n", "<space>vs", function()
          local find_command = { "rg", "--files", "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column",
            "--smart-case", "--glob=!*veloce.med*", "--glob=!*veloce.wave*" }

          if not vim.env.STEM then
            print("ERR: $STEM is not set")
            return nil
          end

          local stem = vim.env.STEM
          local search_dirs = { "/src/emu", "/src/buildtime", "/src/runtime", "/src/lib", "/import/", "_env" }

          for i = #search_dirs, 1, -1 do
            search_dirs[i] = vim.fs.joinpath(stem, search_dirs[i])
            if vim.fn.isdirectory(search_dirs[i]) == 0 then
              table.remove(search_dirs, i)
            end
          end

          if IS_VEL_BUILD_DIR == 1 then
            table.insert(search_dirs, 1, vim.fn.getcwd())
          end

          require("telescope.builtin").find_files {
            --cwd = search_dirs[1],
            cwd = stem,
            find_command = find_command,
            search_dirs = search_dirs
          }
        end,
        { desc = "telescope search p4 veloce areas" })
end

return M
