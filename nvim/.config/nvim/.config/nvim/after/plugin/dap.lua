local dap = require("dap")

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
dap.configurations.python = {
    {
        name = "Launch",
        type = "python",
        request = "launch",
        program = "${file}",
    },
}

vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>ds', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end)
