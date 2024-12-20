-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use Intelephense instead of PhpActor
vim.g.lazyvim_php_lsp = "intelephense"

-- Enable dynamic window titles (otherwise just Nvim/Neovide)
vim.opt.title = true

-- Increase PHPStan memory limit, otherwise it will crash on large projects
vim.env.PHPSTAN_MEMORY_LIMIT = "1G"

-- ####################
-- ## Neovide options #
-- ####################

-- Use left option key on Macs as alt key
-- NOTE: Make sure to disable conflicting Mac shortcuts in System Preferences > Keyboard > Shortcuts
vim.g.neovide_input_macos_option_key_is_meta = "only_left"

-- Change font size
vim.g.neovide_scale_factor = 0.8
