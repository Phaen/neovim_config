---@type LazySpec
return {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup {
      enable_cmp_source = false,
      enable_chat = true,
      virtual_text = {
        enabled = true,
        default_filetype_enabled = true,
      },
    }
  end,
}
