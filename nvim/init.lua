vim.fn.has("nvim-0.5")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        "rust-lang/rust.vim",
        "scrooloose/nerdtree",
        "Xuyuanp/nerdtree-git-plugin", -- Show git status in nerd-tre
        "ctrlpvim/ctrlp.vim",
        "voldikss/vim-floaterm",
        "tpope/vim-fugitive",
        "leafgarland/typescript-vim",
        "pangloss/vim-javascript",
        "peitalin/vim-jsx-typescript",
        -- 'fatih/vim-go',
        "hashivim/vim-terraform",
        {
            "folke/zen-mode.nvim",
            opts = {window = {width = 180}}
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "simrat39/rust-tools.nvim",
        -- Completion framework:
        "hrsh7th/nvim-cmp",
        -- LSP completion source:
        "hrsh7th/cmp-nvim-lsp",
        -- Useful completion sources:
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/vim-vsnip",
        -- other plugins...
        {
            "folke/trouble.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            opts = {}
        },
        {
            "ray-x/go.nvim",
            dependencies = {
                -- optional packages
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
                "nvim-treesitter/nvim-treesitter"
            },
            config = function()
                require("go").setup()
            end,
            event = {"CmdlineEnter"},
            ft = {"go", "gomod"},
            build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        },
        -- colours
        {"ellisonleao/gruvbox.nvim", priority = 1000, config = true}
    }
)

-- Old stuff from my previous vim config
vim.cmd(
    [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set relativenumber
  set number
  set ruler
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * NERDTreeClose | CtrlP
  let g:ctrlp_working_path_mode = 'r'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmp = 'CtrlP'

  set clipboard^=unnamed
  set hidden
  command! -nargs=1 Gc Git add % | Git commit -m <f-args>
  command! Config tabe ~/.config/nvim/init.lua
  set timeoutlen=100 ttimeoutlen=0

  hi Pmenu ctermbg=white
  set background=dark
]]
)

-- Language server clients
require("mason").setup(
    {
        ui = {
            icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = ""
            }
        }
    }
)

require("mason-lspconfig").setup()

require("go").setup {
    lsp_cfg = false
    -- other setups...
}
local cfg = require "go.lsp".config() -- config() return the go.nvim gopls setup

-- configure language servers
local lspconfig = require("lspconfig")
lspconfig.gopls.setup(cfg)
lspconfig.tsserver.setup({})
lspconfig.pyright.setup({})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
vim.opt.shortmess = vim.opt.shortmess + {c = true}
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local rt = require("rust-tools")

rt.setup(
    {
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-k>", rt.hover_actions.hover_actions, {buffer = bufnr})
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {buffer = bufnr})
            end
        }
    }
)

-- Completion Plugin Setup
local cmp = require "cmp"
cmp.setup(
    {
        -- Enable LSP snippets
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- Add tab support
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm(
                {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }
            )
        },
        -- Installed sources:
        sources = {
            {name = "path"}, -- file paths
            {name = "nvim_lsp", keyword_length = 3}, -- from language server
            {name = "nvim_lsp_signature_help"}, -- display function signatures with current parameter emphasized
            {name = "nvim_lua", keyword_length = 2}, -- complete neovim's Lua runtime API such vim.lsp.*
            {name = "buffer", keyword_length = 2}, -- source current buffer
            {name = "vsnip", keyword_length = 2}, -- nvim-cmp source for vim-vsnip
            {name = "calc"} -- source for math calculation
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        formatting = {
            fields = {"menu", "abbr", "kind"},
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = "λ",
                    vsnip = "⋗",
                    buffer = "Ω",
                    path = "🖫"
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end
        }
    }
)

vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
        callback = function()
            vim.api.nvim_set_hl(0, "@lsp.type.variable", {bold = false})
            vim.api.nvim_set_hl(0, "LspInlayHint", {bold = false})
        end
    }
)

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
