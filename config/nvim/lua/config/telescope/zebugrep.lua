local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values
local M = {}

local zebu_find = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }

      --- pieces[1] is string to search
      --- pieces[2] defines files to search
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      --- These are the zebu things to NOT search
      --- Need to expand this list as I work with designs which are too large to search
      --- Example: table.insert(args, "--glob=!README*")
      table.insert(args, "--glob=!backend_default")

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Zebu Find",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<space>fzf", zebu_find, { desc = "telescope zebu grep" })
  vim.keymap.set("n", "<space>fzl", function() require('telescope.builtin').find_files {search_dirs = {"zcui.work/zCui/log", "zcui.work/zCui/backup/latest"}} end, {desc = "telescope search zebu logs"})
end

return M
