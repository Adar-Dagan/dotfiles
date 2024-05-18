-- Install lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.jukit_mappings = 0

require("lazy").setup({
    -- Color theme
    { "EdenEast/nightfox.nvim" },

    -- Editor plugins
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-telescope/telescope.nvim',   tag = '0.1.3',      dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-treesitter/playground' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'github/copilot.vim' },
    { 'tpope/vim-commentary' },
    { 'mfussenegger/nvim-dap' },
    { 'mfussenegger/nvim-dap-python' },
    { 'ThePrimeagen/vim-be-good' },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'luk400/vim-jukit',
    },
    { "lewis6991/gitsigns.nvim" },
    { "stevearc/conform.nvim" },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup({})
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

 
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
     {'williamboman/mason.nvim'},
     {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
}, {
    git = {
        timeout = 300,
    }
})
