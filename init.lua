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

-- Code Runner
local group = vim.api.nvim_create_augroup("CodeRunner", { clear = true })

local runners = {
    c = "clang -pedantic-errors -Wall -Wextra -std=c23 -o %:t:r %:t && ./%:t:r",
    cpp = "clang++ -pedantic-errors -Wall -Wextra -std=c++23 -o %:t:r %:t && ./%:t:r",
    lua = "lua %:t",
    python = "python3 %:t",
    sh = "bash %:t",
}

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = vim.tbl_keys(runners),
    callback = function(args)
        vim.keymap.set("n", "<leader>R", function()
            local cmd = runners[vim.bo[args.buf].filetype]

            vim.cmd.write()
            vim.cmd("botright 10split")
            vim.cmd("terminal cd %:p:h && " .. cmd)
            vim.cmd.startinsert()
        end, {
            buffer = args.buf,
            desc = "Run Current File",
            silent = true,
        })
    end,
})

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
