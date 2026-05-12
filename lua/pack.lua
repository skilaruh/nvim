vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/arborist-ts/arborist.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" }

})


-- Loading plugin configs
require("plugins.autopairs")
require("plugins.which_key")
require("plugins.arborist")
require("plugins.lspconfig")
require("plugins.blink")
require("plugins.snacks")
require("plugins.lualine")
