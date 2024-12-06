vim.g.neovide_scale_factor = 0.8
vim.env.PHPSTAN_MEMORY_LIMIT = "1G"

-- Disable diagnostics on .env files
local envGroup = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env",
  group = envGroup,
  callback = function(args) vim.diagnostic.disable(args.buf) end,
})
