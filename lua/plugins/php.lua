---@type LazySpec
return {
  -- Setup vendor formatters
  {
    "stevearc/conform.nvim",
    opts = {
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
  -- Disable phpcsfixer linting, setup by the php extra
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },
}
