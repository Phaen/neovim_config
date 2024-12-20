-- Configure Blade treesitter parser
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
}

-- Add Blade filetype
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

---@type LazySpec
return {
  -- Formatter config for blade
  {
    "conform.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "blade-formatter",
          },
        },
      },
    },
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
  },

  -- Treesitter configuration for Blade
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "blade" },
    },
  },
  -- Completions for Blade
  -- WARN: Currently useless in this config, because of no blink support
  {
    "ricardoramirezr/blade-nav.nvim",
    ft = { "blade", "php" },
    opts = {
      close_tag_on_complete = true,
    },
  },
}
