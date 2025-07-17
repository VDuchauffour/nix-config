-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- Plugins
  -- A markdown preview directly in your neovim.
  {
    "ellisonleao/glow.nvim",
    lazy = false,
  },
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- Vim plugin for automatic time tracking and metrics generated from your programming activity.
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  -- Show code context. Sticky scroll.
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  -- Rainbow delimiters for Neovim with Tree-sitter
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
    opts = {
      condition = function(bufnr)
        local buf_utils = require "astrocore.buffer"
        return buf_utils.is_valid(bufnr) and not buf_utils.is_large(bufnr)
      end,
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>u("] = {
                function()
                  local bufnr = vim.api.nvim_get_current_buf()
                  require("rainbow-delimiters").toggle(bufnr)
                  require("astrocore").notify(
                    string.format(
                      "Buffer rainbow delimeters %s",
                      require("rainbow-delimiters").is_enabled(bufnr) and "on" or "off"
                    )
                  )
                end,
                desc = "Toggle rainbow delimeters (buffer)",
              },
            },
          },
        },
      },
    },
  },
  -- A more adventurous wildmenu
  {
    "gelguy/wilder.nvim",
    lazy = false,
  },
  -- LSP signature hint as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  --  The Refactoring library based off the Refactoring book by Martin Fowler
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("refactoring").setup() end,
    lazy = false,
  },
  --  Disable/Enable LSP clients and NullLS sources for buffers.
  -- {
  --   "adoyle-h/lsp-toggle.nvim",
  --   lazy = false,
  --   config = function()
  --     require("lsp-toggle").setup {
  --       create_cmds = true, -- Whether to create user commands
  --       telescope = true, -- Whether to load telescope extensions
  --     }
  --   end,
  -- },
  -- -- Neovim plugin for toggling the LSP diagnostics.
  -- {
  --   "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
  --   event = "BufRead",
  --   config = function() require("toggle_lsp_diagnostics").init(vim.diagnostic.config()) end,
  -- },
  -- Intelligently reopen files at your last edit position.
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = {
          "quickfix",
          "nofile",
          "help",
        },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
  -- A simple neovim plugin to let you choose what virtual environment to activate in neovim.
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-dap",
  --     "mfussenegger/nvim-dap-python", --optional
  --     { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  --   },
  --   lazy = false,
  --   branch = "regexp", -- This is the regexp branch, use this for the new version
  --   config = function() require("venv-selector").setup() end,
  --   keys = {
  --     -- Keymap to open VenvSelector to pick a venv.
  --     { "<leader>ls", "<cmd>VenvSelect<cr>" },
  --     -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
  --     { "<leader>lc", "<cmd>VenvSelectCached<cr>" },
  --   },
  -- },
}
