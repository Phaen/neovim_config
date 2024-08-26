---@type LazySpec
return {

  -- == Install Plugins ==
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        require("telescope").load_extension "projects",
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },

  {
    "ggandor/leap.nvim",
    config = function() require("leap").create_default_mappings() end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("wildfire").setup() end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "codeium", priority = 1000 })
      return opts
    end,
  },

  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        enable_chat = true,
      }
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      opts.hint_prefix = "➡️ "
      opts.hint_enable = false
      require("lsp_signature").setup(opts)
    end,
  },

  {
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp", -- if using nvim-cmp
    },
    ft = { "blade", "php" }, -- optional, improves startup time
  },

  -- == Overriding Plugins ==

  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      }
      table.insert(opts.section.buttons.val, 3, opts.button("SPC f p", "  Find Project"))
      return opts
    end,
  },
}
