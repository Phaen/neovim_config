---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = function()
          local has_pint = vim.fn.glob "vendor/bin/pint" ~= ""
          return has_pint and { "pint" } or { "phpcsfixer" }
        end,
      },
      formatters = {
        pint = {
          command = "vendor/bin/pint",
          args = { "--test", "-" },
          stdin = true,
        },
      },
    },
  },
}
