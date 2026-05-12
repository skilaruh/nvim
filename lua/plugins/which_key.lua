local wk = require("which-key")

wk.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
})

vim.keymap.set("n", "<leader>?", function()
    wk.show({global = false})
end,
{desc = "Buffer Local Keymaps (whick-key)"}
)
