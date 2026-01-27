return {
  {
    dir = "~/dev/claude-tutor/nvim",
    name = "tutor",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("tutor").setup({
        auto_review = true,
        thresholds = {
          min_lines = 2,
        },
      })
    end,
  },
}
