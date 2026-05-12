-- Basic Settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.o.wrap = false
vim.o.breakindent = true
vim.o.linebreak = true

vim.o.swapfile = false
vim.o.backup = false

vim.o.cursorline = true
vim.o.termguicolors = true

vim.o.scrolloff = 8

vim.o.cmdheight = 0

vim.o.winborder = "rounded"

vim.o.clipboard = "unnamedplus"

vim.o.showtabline = 0

vim.opt.fillchars = { eob = " " } --remove tilda to show end of file

-- Imports
require("pack")

-- Theme
vim.cmd.colorscheme('vague')

-- Vim Core UI 2 Enable
require("vim._core.ui2").enable({})

--- Keybinds
vim.keymap.set("n", "<leader>nr", "<cmd>restart<cr>", {
    desc = "Restart Neovim (:restart)",
})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>vpu", function()
        vim.pack.update()
    end,
    { desc = "Update all packages" })
