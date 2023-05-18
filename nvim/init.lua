vim.opt.scrolloff = 4
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("i", "jk", "<ESC>")

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

require("lazy").setup({
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "folke/which-key.nvim",
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
    end
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme "tokyonight-storm"
    end,
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
    config = function() 
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.tangle"] = {},
          ["core.esupports.metagen"] = {
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
    })

    vim.keymap.set("n", "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>")
    vim.keymap.set("n", "<leader>nt", ":Neorg tangle current-file<CR>")
    -- vim.keymap.set("n", "<leader>ni", ":Neorg inject-metadata<CR>")

    --vim.api.nvim_create_autocmd("BufWritePre", {
    --  pattern = { "*.norg" },
    --  command = ":Neorg update-metadata",
    --})
  end,
  dependencies = { 
    "nvim-lua/plenary.nvim"
  },
},
{
  'nvim-lualine/lualine.nvim',
  opts = { options = { theme = "tokyonight" } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}
})
