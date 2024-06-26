local conform = require("conform")

conform.setup({
	format_on_save = {
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
})

vim.keymap.set("n", "<leader>f", function()
	conform.format({ lsp_fallback = true }, function(err, did_edit)
		if err then
			print("Error: " .. err)
			return
		end

		print("Formatted: " .. (did_edit and "yes" or "no"))
	end)
end, { desc = "[F]ormat" })
