-- Get directory in docker compose file that project files are mapped to
local function get_docker_dir()
  local file = io.open("docker-compose.yml", "r")
  if file then
    local content = file:read("*all")
    file:close()

    local in_volumes = false
    for line in content:gmatch("[^\r\n]+") do
      if line:match("^%s*volumes:") then
        in_volumes = true
      elseif in_volumes and line:match("^%s*%-%s*['\"]?%./?:") then
        return line:match(":(.-)['\"]?$")
      elseif in_volumes and not line:match("^%s*%-") then
        in_volumes = false
      end
    end
  end

  return "/var/www/html" -- hail mary
end

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "phpstan",
        "intelephense",
        "php-debug-adapter",
        "php-cs-fixer",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- Configure adapter
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }

      -- Configure adapter configurations
      local base_config = {
        type = "php",
        request = "launch",
        port = 9003,
        xdebugSettings = {
          max_children = 100,
        },
      }

      dap.configurations.php = {
        vim.tbl_extend("force", base_config, {
          name = "PHP: Xdebug docker",
          pathMappings = function()
            return {
              [get_docker_dir()] = "${workspaceFolder}",
            }
          end,
        }),
        vim.tbl_extend("force", base_config, {
          name = "PHP: Xdebug local",
        }),
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint_vendor", "phpcsfixer_vendor", "php_cs_fixer", stop_after_first = true },
      },
      formatters = {
        pint_vendor = {
          command = "vendor/bin/pint",
        },
        phpcsfixer_vendor = {
          command = "vendor/bin/php-cs-fixer",
          args = { "fix", "--sequential", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        php = { "phpstan" },
      },
    },
  },
}
