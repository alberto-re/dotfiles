--
-- Plugins configuration
--

require("user.plugins")

-- LSP
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

require("lspconfig").rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = true,
                disabled = {
                    "unresolved-proc-macro",
                    "unresolved-macro-call",
                },
                enableExperimental = true,
            },
        }
    }
}

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Theme

require("nightfox").setup()

vim.cmd("colorscheme nightfox")

require("ibl").setup()

-- Completion
local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
  formatting = {
    fields = {"abbr", "kind", "menu"},
    format = require("lspkind").cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
    })
  }
})

-- Statusline

-- As stated in the lualine README to enable icons install a patched font
-- like this for example: https://github.com/ryanoasis/nerd-fonts
require("lualine").setup()

--
-- Options
--

vim.cmd([[set ff=unix fixeol]])
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.clipboard = "unnamedplus"

--
-- Custom keyboard mappings
--

-- Map <leader> to space: easy to reach with both hands
vim.g.mapleader = " "

-- Re-execute last executed command
vim.keymap.set("n", "<leader>r", ":!!<cr>", {})

-- Quickly move between next/previous open buffer
vim.keymap.set("n", "<leader>n", ":bnext<cr>", {})
vim.keymap.set("n", "<leader>b", ":bprev<cr>", {})

-- Reformat currently open buffer if LSP supports it
vim.keymap.set("n", "<leader><space>", function()
  vim.lsp.buf.format { async = true }
end, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {})

-- Searching
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>gl", builtin.live_grep, {})

require("telescope").setup({
    pickers = {
        find_files = {
            layout_config = {
                prompt_position = "top",
                width = 0.95,
                height = 0.95,
            },
            sorting_strategy = "ascending",
        },
        live_grep = {
            layout_config = {
                prompt_position = "top",
                width = 0.95,
                height = 0.95,
            },
            sorting_strategy = "ascending",
        },

    },
})

-- Diagnostics
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {})
