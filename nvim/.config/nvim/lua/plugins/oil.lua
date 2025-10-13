return {
    'stevearc/oil.nvim',
    opts = function()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>", { desc = "Open [P]roject [V]iew" })

        return {
            view_options = {
                show_hidden = true,
            },
        }
    end
}
