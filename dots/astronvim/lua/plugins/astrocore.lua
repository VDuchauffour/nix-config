-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        autochdir = true,
        showmatch = true,
        timeoutlen = 50,

      },
      g = { -- vim.g.<key>
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- navigate buffer tabs with `H` and `L`
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },

        -- mappings seen under group name "Buffer"
        ["<leader>bD"] = {
          function()
            require("astronvim.utils.status").heirline.buffer_picker(
              function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },

        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<leader>b"] = { name = "Buffers" },

        -- Leader bindings for WhichKey
        ["<leader>d"] = { '"_d', desc = "Delete without yanking" },
        ["<leader>W"] = { ":noa w<cr>", desc = "Save without formatting" },
        ["<leader>s"] = { ":SymbolsOutline<cr>", desc = "Toggle SymbolOutline" },
        ["<leader>lo"] = { ":ToggleLSP<cr>", desc = "Toggle LSP for current buffer" },
        ["<leader>lO"] = { ":ToggleNullLSP<cr>", desc = "Toggle NullLSP source for all buffers" },

        -- set Y to yanking from cursor to the end of the line
        Y = { "y$", noremap = true }, -- nnoremap Y y$

        -- delete a character will not yanking it
        x = { '"_x', noremap = true }, -- nnoremap x "_x
        X = { '"_X', noremap = true }, -- nnoremap X "_X

        -- change will not yanking
        c = { '"_c', noremap = true }, -- nnoremap c "_c
        C = { '"_C', noremap = true }, -- nnoremap C "_C

        -- add a keymap for <Esc> and ²
        ["²"] = { "<esc>", noremap = true }, -- nnoremap ² :<esc>

        -- cut the full word when using b or B
        ["db"] = { "vbd", noremap = true }, --nnoremap db vbd
        ["dB"] = { "vBd", noremap = true }, --nnoremap dB vBd

        -- yank the full word when using b or B
        ["yb"] = { "vby", noremap = true }, --nnoremap yb vby
        ["yB"] = { "vBy", noremap = true }, --nnoremap yB vBy
      },
      v = {
        -- Leader bindings for WhichKey
        ["<leader>d"] = { '"_d', desc = "Delete without yanking" },

        -- set Y to yanking from cursor to the end of the line
        Y = { "y$", noremap = true }, -- vnoremap Y y$

        -- delete a character will not yanking it
        x = { '"_x', noremap = true }, -- vnoremap x "_x
        X = { '"_X', noremap = true }, -- vnoremap X "_X

        -- change will not yanking
        c = { '"_c', noremap = true }, -- vnoremap c "_c
        C = { '"_C', noremap = true }, -- vnoremap C "_C

        -- replace currently selected text with default register without yanking it
        p = { "pgvy", noremap = true }, -- vnoremap p pgvy
        P = { "Pgvy", noremap = true }, -- vnoremap p Pgvy

        -- add a keymap for <Esc> and ²
        ["²"] = { "<esc>", noremap = true }, -- vnoremap ² :<esc>

        -- Better indenting
        ["<"] = { "<gv", noremap = true },
        [">"] = { ">gv", noremap = true },
      },
      i = {
        -- add a keymap for <Esc> and ²
        ["²"] = { "<esc>", noremap = true }, -- inoremap ² :<esc>
      },
    },
  },
}
