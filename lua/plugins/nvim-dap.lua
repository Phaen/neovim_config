local function get_docker_workdir()
  local file = io.open("docker-compose.yml", "r")
  if file then
    local content = file:read "*all"
    file:close()

    local in_volumes = false
    for line in content:gmatch "[^\r\n]+" do
      if line:match "^%s*volumes:" then
        in_volumes = true
      elseif in_volumes and line:match "^%s*%-%s*['\"]?%./?:" then
        return line:match ":(.-)['\"]?$"
      elseif in_volumes and not line:match "^%s*%-" then
        in_volumes = false
      end
    end
  end

  return "/var/www/html" -- hail mary
end

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("mason-nvim-dap").setup {
        automatic_installation = true,
        ensure_installed = {
          "php-debug-adapter",
        },
      }

      local dap = require "dap"

      -- Let mason-nvim-dap set up the adapter first
      -- Overwrite the configuration after to get rid of bad defaults
      vim.defer_fn(function()
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
                [get_docker_workdir()] = "${workspaceFolder}",
              }
            end,
          }),
          vim.tbl_extend("force", base_config, {
            name = "PHP: Xdebug local",
          }),
        }
      end, 100)
    end,
  },
}
