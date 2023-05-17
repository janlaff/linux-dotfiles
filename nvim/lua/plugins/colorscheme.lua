return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "storm",
      styles = {
        keywords = { italic = true },
      }
    })

    vim.cmd.colorscheme "tokyonight-storm"
  end
}
