---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Disable diagnostics for .env files
    local on_publish_diagnostics = vim.lsp.diagnostic.on_publish_diagnostics
    opts.servers.bashls = vim.tbl_deep_extend("force", opts.servers.bashls or {}, {
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, res, ...)
          local file_name = vim.fn.fnamemodify(vim.uri_to_fname(res.uri), ":t")
          if string.match(file_name, "^%.env") == nil then
            return on_publish_diagnostics(err, res, ...)
          end
        end,
      },
    })

    -- Add stubs for intelephense
    opts.servers.intelephense = {
      environment = {
        includePaths = {
          "~/.composer/vendor/php-stubs",
          "vendor/php-stubs",
        },
      },
      files = {
        maxSize = 10000000,
      },
    }
  end,
}
