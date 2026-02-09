-- Requires version 0.12 or above.

-- Get rid of annoying "Undefined global `vim`" warning due
-- to lua_ls not recognizing where the variable comes from.
---@diagnostic disable: undefined-global

-- Disable the use of a swapfile for the buffer.
vim.opt.swapfile = false
-- Number of columns per indentation.
vim.opt.shiftwidth = 4
-- Insert <Tab> as an appropriate number of spaces.
vim.opt.expandtab = true
-- Number of columns to use to display <Tab>.
vim.opt.tabstop = 4
-- Ignore case in search patterns.
vim.opt.ignorecase = true
-- Print the line number in front of current line, and the line number
-- relative to the line with the cursor in front of each other line.
vim.opt.number = true
vim.opt.relativenumber = true
-- Border style for floating windows.
vim.opt.winborder = "rounded"
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Sync with system clipboard.
vim.opt.clipboard = "unnamedplus"

-- Declare plugins to install.
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/vladdoster/remember.nvim" },
})

-- Enable installed plugins.
require("Comment").setup()
require("mini.pick").setup({
  window = {
    config = {
      width = 120,
      height = 30,
    },
  },
})
require("remember")
require("rose-pine").setup()

-- Enable LSP for languages we care about.
-- Run ':checkhealth vim.lsp' for diagnostics.
-- LSP implementations must be installed manually.
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")

-- Display LSP messages inline.
vim.diagnostic.config({
    -- Display LSP diagnostics inline.
    virtual_text = true,
    -- Only update diagnostics after leaving insert mode.
    update_in_insert = false,
})

-- Set color theme.
vim.cmd("colorscheme rose-pine")

-- Map <leader> to spacebar.
vim.g.mapleader = " "

-- Leader mappings.
-- Mappings for 'mini.pick'.
vim.keymap.set("n", "<Leader>ff", "<Cmd>Pick files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<Leader>fb", "<Cmd>Pick buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<Leader>gf", "<Cmd>Pick grep_live<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<Leader>gc", "<Cmd>Pick grep pattern='<cword>'<CR>", { desc = "Grep current word" })
-- Mappings for Language Server Protocol.
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, {})
-- Quality of life mappings.
vim.keymap.set("n", "<Leader>w", "<CMD>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<Leader>q", "<CMD>q<CR>", { desc = "Quit current file" })
vim.keymap.set("n", "<Leader>wq", "<CMD>wq<CR>", { desc = "Save current file then quit" })
