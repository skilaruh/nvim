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

-- Togglable Terminal
local term = {
    buf = nil,
    win = nil,
}

local function terminal_job_running(buf)
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
        return false
    end

    local ok, job_id = pcall(function()
        return vim.b[buf].terminal_job_id
    end)

    if not ok or not job_id then
        return false
    end

    return vim.fn.jobwait({ job_id }, 0)[1] == -1
end

local function toggle_terminal()
    -- If terminal window is open, close only the window.
    -- The terminal buffer/process stays alive.
    if term.win and vim.api.nvim_win_is_valid(term.win) then
        vim.api.nvim_win_close(term.win, true)
        term.win = nil
        return
    end

    -- Open bottom split
    vim.cmd("botright 10split")
    term.win = vim.api.nvim_get_current_win()

    -- Reuse existing terminal buffer if its job is still running
    if terminal_job_running(term.buf) then
        vim.api.nvim_win_set_buf(term.win, term.buf)
    else
        vim.cmd("terminal")
        term.buf = vim.api.nvim_get_current_buf()
        vim.bo[term.buf].buflisted = false
    end

    vim.cmd("startinsert")
end

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

vim.keymap.set("n", "<C-`>", toggle_terminal, {
    desc = "Toggle Terminal",
    silent = true,
})

vim.keymap.set("t", "<C-`>", function()
    vim.cmd.stopinsert()
    toggle_terminal()
end, {
    desc = "Toggle Terminal",
    silent = true,
})
