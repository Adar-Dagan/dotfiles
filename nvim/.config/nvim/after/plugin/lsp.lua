local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, { desc = "[G]o to [D]efinition", buffer = bufnr })
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, { desc = "[H]over", buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, { desc = "[R]ename", buffer = bufnr })
	vim.keymap.set("n", "<leader>gr", function()
		vim.lsp.buf.references()
	end, { desc = "[G]o to [R]eferences", buffer = bufnr })
	vim.keymap.set({ "n", "v" }, "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, { desc = "[C]ode [A]ction", buffer = bufnr })
	vim.keymap.set("n", "<leader>ld", function()
		vim.diagnostic.open_float()
	end, { desc = "[L]ine [D]iagnostics", buffer = bufnr })
end)

local lua_opts = lsp.nvim_lua_ls()
require("lspconfig").lua_ls.setup(lua_opts)

require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-space>"] = cmp.mapping.complete(),
	}),
})
