---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        php = { "pint", "php-cs-fixer", stop_after_first = true },
      },
      formatters = {
        pint = {
          command = "vendor/bin/pint",
        },
        ["php-cs-fixer"] = {
          command = "vendor/bin/php-cs-fixer",
          args = { "fix", "--sequential", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
