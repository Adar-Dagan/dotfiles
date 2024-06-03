vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufnr = event.buf
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
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { desc = "[S]ignature [H]elp", buffer = bufnr })
		vim.keymap.set("n", "<leader>nd", function()
			vim.diagnostic.goto_next()
		end, { desc = "[N]ext [D]iagnostic", buffer = bufnr })
		vim.keymap.set("n", "<leader>pd", function()
			vim.diagnostic.goto_prev()
		end, { desc = "[P]revious [D]iagnostic", buffer = bufnr })
	end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").pyright.setup({ capabilities = lsp_capabilities })

require("neodev").setup({})
require("lspconfig").lua_ls.setup({
	capabilities = lsp_capabilities,
})

require("lspconfig").nil_ls.setup({
	capabilities = lsp_capabilities,
})

require("lspconfig").rust_analyzer.setup({
	capabilities = lsp_capabilities,
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
	sources = {
		{ name = "nvim_lsp" },
		{ name = "supermaven" },
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})
