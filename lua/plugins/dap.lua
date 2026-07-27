local dap = require("dap")

dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

    -- On windows you may have to uncomment this:
    -- detached = false,
}

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
                source_filetype = "python",
            },
        })
    else
        cb({
            type = "executable",
            command = "debugpy",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        })
    end
end

dap.configurations.c = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c



-- debugpy config
local function find_project_root()
    local root = vim.fs.find("pyproject.toml", {
        upward = true,
    })[1]

    if root then
        return vim.fs.dirname(root)
    end

    return vim.fn.getcwd()
end

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
            local root = find_project_root()
            local venv_python = root .. "/.venv/bin/python"

            if vim.fn.executable(venv_python) == 1 then
                return venv_python
            end

            if vim.env.VIRTUAL_ENV then
                return vim.env.VIRTUAL_ENV .. "/bin/python"
            end

            return vim.fn.exepath("python")
        end,
    },
}
