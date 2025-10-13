return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		vim.treesitter.language.register("c", { "opencl" })

		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
		})
	end,
}
