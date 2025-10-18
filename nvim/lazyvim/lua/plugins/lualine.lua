return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, 1, {
        "filetype",
        icons_enabled = false,
        cond = function()
          return vim.fn.filereadable(vim.fn.getcwd() .. "/.git/HEAD") == 0
        end,
        fmt = function()
          return vim.fs.basename(vim.fn.getcwd())
        end,
      })
      table.insert(opts.sections.lualine_b, 1, {
        "filename",
        path = 1, -- Show relative path to project root
        icons_enabled = false,
        cond = function()
          return vim.fn.filereadable(vim.fn.getcwd() .. "/.git/HEAD") == 1
        end,
        fmt = function()
          local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):match("^(.*)\n$")
          if root then
            return vim.fs.basename(root)
          else
            return ""
          end
        end,
      })
    end,
  },
}
