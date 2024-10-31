---@type LazySpec
return {

  -- == Install Plugins ==
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

  {
    "lambdalisue/vim-suda",
    init = function() vim.g.suda_smart_edit = 1 end,
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  {
    "kkoomen/vim-doge",
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()

      vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Refactor extract" })
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Refactor extract to file" })

      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Refactor extract variable" })

      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Refactor inline variable" })

      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Refactor inline function" })

      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Refactor extract block" })
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Refactor extract block to file" })

      vim.keymap.set(
        { "n", "x" },
        "<leader>rr",
        function() require("refactoring").select_refactor() end,
        { desc = "Refactor select refactor" }
      )
    end,
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
