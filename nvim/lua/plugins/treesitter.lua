return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpsate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "lua",
                "c",
                "html",
            },
            auto_install = false,
        })
    end
}
