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

-- vim.o.colorcolumn = "80"

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

-- Toggleable Terminal
local term_buf

local function toggle_terminal()
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_buf(win) == term_buf then
                vim.api.nvim_win_close(win, true)
                return
            end
        end

        if vim.fn.jobwait({ vim.bo[term_buf].channel }, 0)[1] == -1 then
            vim.cmd('botright 10split')
            vim.api.nvim_win_set_buf(0, term_buf)
            vim.cmd.startinsert()
            return
        end

        vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    vim.cmd('botright 10new')
    vim.cmd.terminal()
    term_buf = vim.api.nvim_get_current_buf()
    vim.bo.buflisted = false
    vim.cmd.startinsert()
end

-- Code Runner
local runners = {
    c = 'clang -pedantic -Wall -Wextra -std=c23 %s -o %s && %s',
    cpp = 'clang++ -pedantic -Wall -Wextra -std=c++23 %s -o %s && %s',
    lua = 'lua %s',
    python = 'python3 %s',
    sh = 'bash %s',
}

local function run_code()
    local runner = runners[vim.bo.filetype]
    if not runner or vim.bo.buftype ~= '' or vim.fn.expand('%') == '' then
        return
    end

    vim.cmd.update()

    local file = vim.fn.expand('%:p:S')
    local output = vim.fn.expand('%:p:r:S')
    local cwd = vim.fn.expand('%:p:h')

    vim.cmd('botright 10new')
    vim.fn.jobstart(runner:format(file, output, output), {
        cwd = cwd,
        term = true,
    })

    vim.bo.buflisted = false
    vim.bo.bufhidden = 'wipe'
    vim.cmd.startinsert()
end

-- Keymaps
vim.keymap.set('n', '<leader>nr', '<cmd>restart<cr>', { desc = 'Restart Neovim' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP: Format Buffer' })
vim.keymap.set('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>vpu', vim.pack.update, { desc = 'Update All Packages' })
vim.keymap.set('n', '<leader>R', run_code, { desc = 'Run Current File' })
vim.keymap.set('n', '<C-`>', toggle_terminal, { desc = 'Toggle Terminal' })

vim.keymap.set('t', '<C-`>', function()
    vim.cmd.stopinsert()
    toggle_terminal()
end, { desc = 'Toggle Terminal' })
