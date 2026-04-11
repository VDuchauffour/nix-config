-- Customize Treesitter
-- In AstroNvim v6, treesitter configuration is done through AstroCore

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = {
        "lua",
        "vim",
        -- add more arguments for adding more treesitter parsers
      },
      highlight = true,
    },
  },
}
