local dap = require("dap")

vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "toggle [B]reakpoint" })
vim.keymap.set("n", "<leader>co", function()
	dap.continue()
end, { desc = "[Co]ntinue" })
vim.keymap.set("n", "<leader>si", function()
	dap.step_into()
end, { desc = "[S]tep [I]nto" })
vim.keymap.set("n", "<leader>sn", function()
	dap.step_over()
end, { desc = "[S]tep [N]ext" })
vim.keymap.set("n", "<leader>so", function()
	dap.step_over()
end, { desc = "[S]tep [O]ut" })
vim.keymap.set({ "n", "v" }, "<Leader>e", function()
	require("dap.ui.widgets").hover()
end, { desc = "[E]valuate" })
vim.keymap.set("n", "<Leader>tr", function()
	require("dap.repl").toggle(nil, "vertical botright 80new")
end, { desc = "[T]oggle [R]epl" })

local repl = require("dap.repl")
repl.commands = vim.tbl_extend("force", repl.commands, {
	exit = { "exit", ".exit" },
	continue = { "c", ".c" },
	next_ = { "n", ".n" },
	into = { "into", ".into" },
	out = { "out", ".out" },
	up = { "up", ".up" },
	down = { "down", ".down" },
	scopes = { "scopes", ".scopes" },
})

dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

require("nvim-dap-virtual-text").setup({})
