local js_ts_formatter = function(bufnr)
  local has_eslint = #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })
    > 0

  if has_eslint then
    return { "prettier", lsp_format = "last", name = "eslint" }
  end

  return { "prettier", lsp_format = "fallback" }
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["json"] = {},
      ["jsonc"] = {},
      ["javascript"] = js_ts_formatter,
      ["javascriptreact"] = js_ts_formatter,
      ["typescript"] = js_ts_formatter,
      ["typescriptreact"] = js_ts_formatter,
    },
  },
}
