local mason-lsp = require("mason-lspconfig")

mason-lsp.setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
        "ruff",
    }
})

