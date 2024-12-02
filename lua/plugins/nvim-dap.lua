local dc_workdir = "/var/www/html/"

-- Parse container path from the docker-compose volume
local file = io.open("docker-compose.yml", "r")
if file then
  local content = file:read "*all"
  file:close()

  local in_volumes = false
  for line in content:gmatch "[^\r\n]+" do
    if line:match "^%s*volumes:" then
      in_volumes = true
    elseif in_volumes and line:match "^%s*%-%s*['\"]?%./?:" then
      dc_workdir = line:match ":(.+)['\"]?$"
      break
    elseif in_volumes and not line:match "^%s*%-" then
      in_volumes = false
    end
  end
end

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/vscode-php-debug/out/phpDebug.js" },
        --[[ Install vscode-php-debug in your home directory
          git clone https://github.com/xdebug/vscode-php-debug.git
          cd vscode-php-debug
          npm install && npm run build
        ]]
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Xdebug docker-compose",
          port = 9003,
          pathMappings = {
            [dc_workdir] = "${workspaceFolder}",
          },
          xdebugSettings = {
            max_children = 100,
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Xdebug local",
          port = 9003,
          xdebugSettings = {
            max_children = 100,
          },
        },
      }
    end,
  },
}
