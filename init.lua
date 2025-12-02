-- Basic Settings
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

vim.opt.winborder = "rounded"

vim.opt.clipboard:append 'unnamedplus'

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Add new line to the end of the file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup('UserOnSave', {}),
    pattern = '*',
    callback = function()
        local n_lines = vim.api.nvim_buf_line_count(0)
        local last_nonblank = vim.fn.prevnonblank(n_lines)
        if last_nonblank <= n_lines then
            vim.api.nvim_buf_set_lines(0,
                last_nonblank, n_lines, true, { '' })
        end
    end,
})

-- Keybindings
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>lps", ":LivePreview start<CR>", { desc = "Being Browser Preview" })
vim.keymap.set("n", "<leader>lpc", ":LivePreview close<CR>", { desc = "Close Browser Preview" })


-- Loading Lazy
require("config.lazy")

-- Loading LSP servers
vim.lsp.enable({ "clangd", "gopls", "lua_ls", "ruff" })
