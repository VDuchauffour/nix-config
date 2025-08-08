return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window.width = 40
    opts.filesystem.filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = true }
    return opts
  end,
}
