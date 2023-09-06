local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
            return { "--python-executable", virtual .. "/bin/python3" }
            end,
        }),
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.sql_formatter,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
})
