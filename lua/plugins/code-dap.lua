return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/vscode-php-debug/out/phpDebug.js" },
        -- git clone https://github.com/xdebug/vscode-php-debug.git
        -- cd vscode-php-debug
        -- npm install && npm run build
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Xdebug",
          port = 9003,
          pathMappings = {},
          xdebugSettings = {
            max_children = 100,
          },
          -- stopOnEntry
          -- ignore: An optional array of glob patterns that errors should be ignored from (for example **/vendor/**/*.php)
        },
      }

      -- Example:
      -- -- nvim-dap-local.lua for ar3
      -- local dap = require "dap"
      -- dap.configurations.php[1].pathMappings = {
      --   ['/buildkit/build/'] = '/var/www/adyen.artfulrobot.uk/civicrm-buildkit-docker/build/'
      -- }
      -- pcall(require, 'code-dap-local')
      --require "code-dap-local"

      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
    end,
  },
}
