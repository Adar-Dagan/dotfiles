-- Default options
require('nightfox').setup({
    options = {
        colorblind = {
            enable = false,        -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
            severity = {
                protan = 0.8,      -- Severity [0,1] for protan (red)
                deutan = 0.4,      -- Severity [0,1] for deutan (green)
                tritan = 0,        -- Severity [0,1] for tritan (blue)
            },
        },
    }
})

-- setup must be called before loading
vim.cmd("colorscheme duskfox")

-- vim.o.background = "dark"

-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_foreground = 'original'
-- -- vim.g.gruvbox_material_diagnostic_text_highlight = 1

-- vim.g.gruvbox_material_better_performance = 1

-- -- vim.g.gruvbox_baby_background_color = 'dark'
-- -- vim.g.gruvbox_baby_comment_style = 'bold'

-- vim.cmd("colorscheme gruvbox-material")
-- Default options:
-- require("gruvbox").setup({
--     italic = {
--         strings = false,
--         emphasis = false,
--         comments = false,
--         operators = false,
--         folds = true,
--     },
--     contrast = "hard", -- can be "hard", "soft" or empty string
-- })
-- vim.cmd("colorscheme gruvbox")
