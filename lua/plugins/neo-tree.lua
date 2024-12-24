---@type LazyPluginSpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_by_name = {
          "node_modules",
          "vendor",
          "/build/",
          "/dist/",
          "npm-debug.log*",
          "yarn-debug.log*",
          "yarn-error.log*",
          "package-lock.json",
          "yarn.lock",
          "composer.lock",
        },
        hide_by_pattern = {
          "*.meta",
          "*.cache",
          "_*",
        },
        always_show_by_pattern = {
          ".env*",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = {
          ".null-ls_*",
          ".conform*",
          "*~",
        },
      },
    },
  },
}
