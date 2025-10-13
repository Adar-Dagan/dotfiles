return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "[A]ppend to Harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle [Q]uick Menu" })

        vim.keymap.set("n", "gj", function() harpoon:list():select(1) end, { desc = "Goto first" })
        vim.keymap.set("n", "gk", function() harpoon:list():select(2) end, { desc = "Goto second" })
        vim.keymap.set("n", "gl", function() harpoon:list():select(3) end, { desc = "Goto third" })
        vim.keymap.set("n", "g;", function() harpoon:list():select(4) end, { desc = "Goto fourth" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "gp", function() harpoon:list():prev() end, { desc = "[G]oto [P]revious" })
        vim.keymap.set("n", "gn", function() harpoon:list():next() end, { desc = "[G]oto [N]ext" })

        return {}
    end
}
