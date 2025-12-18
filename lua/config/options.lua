-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Text wrapping settings
-- These override LazyVim defaults to enable better text wrapping
vim.opt.wrap = true -- Enable line wrapping
vim.opt.linebreak = true -- Break at word boundaries (not mid-word)
vim.opt.breakindent = true -- Maintain indentation on wrapped lines

-- UI settings
vim.opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal
