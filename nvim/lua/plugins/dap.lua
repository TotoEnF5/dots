return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local masonDap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dapVirtualText = require("nvim-dap-virtual-text")

        dapVirtualText.setup()

        masonDap.setup({
            ensure_installed = { "cppdbg" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end
            },
        })

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.configurations = {
            c = {
                {
                    name = "Launch file",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                }
            }
        }

        -- ui
        ui.setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = { {
                elements = { {
                    id = "breakpoints",
                    size = 0.1
                }, {
                    id = "stacks",
                    size = 0.4
                }, {
                    id = "scopes",
                    size = 0.5
                }, },
                position = "left",
                size = 40
            }, {
                elements = { {
                    id = "repl",
                    size = 0.5
                }, {
                    id = "console",
                    size = 0.5
                } },
                position = "bottom",
                size = 10
            } },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        })


        vim.fn.sign_define("DapBreakpoint", { text = "B+" })

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end

        -- keybinds
        vim.keymap.set("n", "<F5>", require("dap").run_last)
        vim.keymap.set("n", "<leader>dc", require("dap").continue)
        vim.keymap.set("n", "<leader>dn", require("dap").step_over)
        vim.keymap.set("n", "<leader>ds", require("dap").step_into)
        vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
        vim.keymap.set("n", "<leader>dk", function()
            require("dap").terminate()
            require("dapui").close()
            require("nvim-dap-virtual-text").toggle()
        end)
    end
}
