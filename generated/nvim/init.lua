vim.opt.scrolloff = 4
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<C-Tab>", ":bp<CR>")
vim.keymap.set("n", "<ESC>", "<ESC>:nohl<CR>")
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>")
vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>")
vim.keymap.set('n', '<leader>fo', ":Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>")
vim.keymap.set("n", "<leader>nt", ":Neorg tangle current-file<CR>")
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
local plugins = {
{
  "williamboman/mason.nvim",
  config = true,
  build = ":MasonUpdate" -- :MasonUpdate updates registry contents
},
{
  "williamboman/mason-lspconfig.nvim",
  config = true,
},
{
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({})
    lspconfig.rust_analyzer.setup({})
  end
},
{
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = true,
},
{
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = { 'nvim-lua/plenary.nvim' },
},
{   
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd.colorscheme("tokyonight-storm")
  end,
},
{
  'nvim-lualine/lualine.nvim',
  -- Also use tokyonight theme here :)
  opts = { options = { theme = "tokyonight" } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }
},
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    }
  }
},
{   
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.tangle"] = {}, -- Add tangling support
      ["core.esupports.metagen"] = { -- Automatically sync document meta
        config = {
          type = "auto",
        }
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            dotfiles = "~/linux-dotfiles"
          },
        },
      },
    },
  },
  dependencies = { 
    "nvim-lua/plenary.nvim"
  },
},
{
  "folke/which-key.nvim",
  config = true,
},
}
require("lazy").setup(plugins)
