-- set up for Python development
return {
  {
    -- make sure python syntax installed by treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    -- ensure black is installed by mason
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        "ruff",
      })
    end,
  },
}
