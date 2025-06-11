-- tweak excludeDirs to include the .devenv directory. If not excluded
-- rust-analyzer will chew up CPU, memory, and battery!
return {
  {
    "mrcjkb/rustaceanvim",
    -- ... other rustaceanvim options
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
                -- Add your directories here:
                ".devenv",
              },
            },
          },
        },
      },
    },
  },
}
