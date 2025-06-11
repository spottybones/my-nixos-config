-- set up for Just development
return {
  {
    -- make sure python syntax installed by treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "just" })
    end,
  },
}
