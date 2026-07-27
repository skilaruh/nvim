local treesitter = require("nvim-treesitter")

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)

        if not lang then
            return
        end

        if not vim.tbl_contains(treesitter.get_available(), lang) then
            return
        end

        if not vim.tbl_contains(treesitter.get_installed(), lang) then
            treesitter.install({ lang })
        end
    end,
})
