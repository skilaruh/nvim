local treesitter = require("nvim-treesitter")


treesitter.install({
    "asm",
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    "cuda",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "latex",
    "llvm",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "r",
    "regex",
    "requirements",
    "rust",
    "sql",
    "toml",
    "typescript",
    "vimdoc",
    "yaml",
    "zig",
})



-- Auto installs parsers on new filetypes
-- vim.api.nvim_create_autocmd("FileType", {
--     callback = function(args)
--         local lang = vim.treesitter.language.get_lang(args.match)
--
--         if not lang then
--             return
--         end
--
--         if not vim.tbl_contains(treesitter.get_available(), lang) then
--             return
--         end
--
--         if not vim.tbl_contains(treesitter.get_installed(), lang) then
--             treesitter.install({ lang })
--         end
--     end,
-- })
