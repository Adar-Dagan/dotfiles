return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mollerhoj/telescope-recent-files.nvim",
		{
			-- "Adar-Dagan/telescope-fzf-native-frecency.nvim",
            dir = "/home/adar/projects/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	opts = function()
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("recent-files")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
		vim.keymap.set("n", "<leader>pa", function()
			builtin.find_files({ no_ignore = true, hidden = true })
		end, { desc = "[P]project [A]ll files" })
		vim.keymap.set("n", "<leader>pl", "zy lua:builtin.live_grep", { desc = "[P]roject [L]ive grep" })
		vim.keymap.set("n", "<leader>gw", builtin.grep_string, { desc = "[G]rep [W]ord" })
		vim.keymap.set("v", "<leader>gw", function()
			-- get region with the cursor position and the visual position
			-- returns a list of the selected text
			local cursor_position = vim.fn.getpos(".")
			local visual_end = vim.fn.getpos("v")
			local selected_text = vim.fn.getregion(cursor_position, visual_end)

			if #selected_text ~= 1 then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
				print("Too many lines selected")
				return
			end
			builtin.grep_string({ search = selected_text[1] })
		end, { desc = "[G]rep [W]ord" })
		vim.keymap.set("n", "<leader>po", function()
			require("telescope").extensions["recent-files"].recent_files({})
		end, { desc = "[P]roject [O]ld files" })

		return {
			defaults = {
				layout_config = {
					height = 0.9999,
					width = 0.9999,
					preview_width = 0.47,
				},
			},
		}
	end,
}
