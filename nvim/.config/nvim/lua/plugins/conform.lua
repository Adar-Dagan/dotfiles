return {
	"stevearc/conform.nvim",
	opts = function()
		local conform = require("conform")

		vim.keymap.set({ "v", "n" }, "<leader>f", function()
			conform.format({ lsp_fallback = false }, function(err, did_edit)
				if err then
					print("Error: " .. err)
				else
					print("Formatted: " .. (did_edit and "yes" or "no"))
				end

				local mode = vim.api.nvim_get_mode().mode
				if vim.startswith(string.lower(mode), "v") then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
				end
			end)
		end, { desc = "[F]ormat" })

		return {
			log_level = vim.log.levels.TRACE,
			formatters_by_ft = {
				cpp = { "clang-format" },
				lua = { "stylua" },
				python = { "black" },
			},
		}
	end,
}
