return {
  -- Blade formatter
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.blade = { "blade_formatter" }
    end,
  },

  -- Treesitter configuration for Blade
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "php_only",
      })
    end,
    config = function(_, opts)
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
      }
    end,
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
