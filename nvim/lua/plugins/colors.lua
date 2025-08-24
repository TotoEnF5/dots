return {
    --[[
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    --]]
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'dracula'
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "dracula"
        }
    }
}
