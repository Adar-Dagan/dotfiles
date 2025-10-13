return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
	},
	init = function()
		vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("rust_analyzer")

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(args)
				local bufnr = args.buf

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, { desc = "[G]o to [D]efinition", buffer = bufnr })
				vim.keymap.set("n", "<leader>rn", function()
					vim.lsp.buf.rename()
				end, { desc = "[R]ename", buffer = bufnr })
				vim.keymap.set("n", "<leader>gr", function()
					vim.lsp.buf.references()
				end, { desc = "[G]o to [R]eferences", buffer = bufnr })
				vim.keymap.set({ "n", "v" }, "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, { desc = "[C]ode [A]ction", buffer = bufnr })
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, { desc = "[S]ignature [H]elp", buffer = bufnr })
				vim.keymap.set("n", "<leader>ld", function()
					vim.diagnostic.open_float()
				end, { desc = "[L]ine [D]iagnostics", buffer = bufnr })
				vim.keymap.set("n", "<leader>ne", function()
					vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
				end, { desc = "[N]ext [E]rror", buffer = bufnr })
				vim.keymap.set("n", "<leader>nd", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, { desc = "[N]ext [D]iagnostic", buffer = bufnr })
				vim.keymap.set("n", "<leader>pe", function()
					vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
				end, { desc = "[P]revious [E]rror", buffer = bufnr })
				vim.keymap.set("n", "<leader>pd", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, { desc = "[P]revious [D]iagnostic", buffer = bufnr })
			end,
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
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
					-- You need Neovim v0.10 to use vim.snippet
					vim.snippet.expand(args.body)
				end,
			},
		})
	end,
}
