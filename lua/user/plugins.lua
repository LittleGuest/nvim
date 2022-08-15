-- 插件配置



local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    -- open_fn = function()
    --   return require("packer.util").float { border = "rounded" }
    -- end,
  },
}

--使用介绍
-- use {
-- "myusername/example", -- 插件的位置字符串
-- 下面的都是可选的
-- disable = boolean, -- 将一个插件标记为非活动状态
-- as = string, -- 指定一个别名，用它来安装这个插件
-- installer = function, -- 指定自定义安装程序。参见下面的 "自定义安装器"。
-- updater = function, -- 指定自定义更新器。参见下面的 "自定义安装器"。
-- after = string or list, -- 指定要在这个插件之前加载的插件。参见下面的 "排序"。
-- rtp = string, -- 指定要添加到运行时间路径中的插件的子目录。
-- opt = boolean, -- 手动标记一个插件为可选。
-- branch = string, -- 指定一个要使用的git分支
-- tag = string, -- 指定一个要使用的git标签。支持 "*"代表 "最新标签"。
-- commit = string, -- 指定一个要使用的git提交。
-- lock = boolean, -- 在更新/同步中跳过更新这个插件。依然可以清理。
-- run = string, function, or table, -- 更新/安装后钩子。参见 "更新/安装钩子"。
-- requires = string or list, -- 指定插件的依赖性。参见 "依赖性"。
-- rocks = string or list, -- 指定该插件的Luarocks依赖项
-- config = string or function, -- 指定该插件加载后要运行的代码。
-- setup键意味着opt = true
-- setup = string or function, -- 指定在这个插件加载之前要运行的代码。
-- 下面的都意味着懒惰的加载，并且意味着opt = true
-- cmd = string or list, -- 指定加载这个插件的命令。可以是一个autocmd模式。
-- ft = string or list, -- 指定加载这个插件的文件类型。
-- keys = string or list, -- 指定加载这个插件的地图。参见 "键绑定"。
-- event = string or list, -- 指定加载这个插件的自动命令事件。
-- fn = string or list -- 指定加载这个插件的函数。
-- cond = string, function, or list of strings/functions, -- 指定一个加载这个插件的条件测试
-- module = string or list -- 指定用于require的Lua模块名称。当要求一个字符串，其开头是
-- 带有这些模块名称之一的时候，这个插件将被加载。
-- module_pattern = string/list -- 指定用于require的Lua模块名称的Lua模式。当
-- 需要一个符合这些模式的字符串时，该插件将被加载。
-- }

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules    TODO: figure out how to use this
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "rcarriga/nvim-notify" -- notify
  use "kyazdani42/nvim-web-devicons" -- icons

  -- Telescope
  use "nvim-telescope/telescope-live-grep-args.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    tag = "nvim-0.6",
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }

  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   requires = {"tami5/sqlite.lua"}   -- NOTE: need to install sqlite lib
  -- }
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-rg.nvim"
  -- use "MattesGroeger/vim-bookmarks"
  -- use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-dap.nvim"

  -- 语法高亮插件 Treesittetr
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    commit = "44b7c8100269161e20d585f24bce322f6dcdf8d2",
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "c81382328ad47c154261d1528d7c921acad5eae5",
  } -- enhance texetobject selection
  use "romgrk/nvim-treesitter-context" -- show class/function at the top
  -- -- use "m-demare/hlargs.nvim"
  -- -- use "SmiteshP/nvim-gps" -- statusline shows class structure
  -- use "andymass/vim-matchup"
  -- use {
  --   "abecodes/tabout.nvim",
  --   wants = { 'vim-treesitter' }, -- or require if not used so far
  -- }

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- use "RishabhRD/popfix"
  -- use "RishabhRD/nvim-lsputils"
  use "kosayoda/nvim-lightbulb" -- code action
  use "ray-x/lsp_signature.nvim" -- show function signature when typing
  -- use {
  --   "ray-x/guihua.lua",
  --   run = 'cd lua/fzy && make'
  -- }
  -- use { 'ray-x/navigator.lua' } -- super powerful plugin  for code navigation

  -- Editor enhance
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "terrortylor/nvim-comment"
  use "Shatur/neovim-session-manager"
  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",
    -- commit = "4f1358e659d51c69055ac935e618b684cf4f1429",
  } -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- 代码片段提示
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  -- use "quangnguyen30192/cmp-nvim-tags"
  -- use "jsfaint/gen_tags.vim"
  -- use "ray-x/cmp-treesitter"
  -- use "f3fora/cmp-spell" -- spell check
  -- use "github/copilot.vim"  -- Copilot setup,
  -- use {
  --   "tzachar/cmp-tabnine", -- use ":CmpTabnineHub" command to login
  --   after = "nvim-cmp",
  --   run = 'bash ./install.sh',
  -- }
  use "ethanholz/nvim-lastplace" -- auto return back to the last modified positon when open a file
  -- use "BurntSushi/ripgrep" -- ripgrep
  -- use "nvim-pack/nvim-spectre" -- search and replace pane
  -- use "haringsrob/nvim_context_vt" -- show if, for, function... end as virtual text
  -- use "code-biscuits/nvim-biscuits" -- AST enhance, require treesitter
  use "tpope/vim-repeat" --  . command enhance
  use "tpope/vim-surround" -- vim surround
  -- use "terryma/vim-expand-region" -- expand/shrink region by +/-
  -- use "meain/vim-printer"

  -- use "akinsho/toggleterm.nvim" -- toggle terminal
  -- use "ahmedkhalf/project.nvim" -- project manager
  use "lukas-reineke/indent-blankline.nvim" -- indent blankline
  use "folke/which-key.nvim" -- which  key
  use {
    "phaazon/hop.nvim", -- like easymotion, but more powerful
    branch = "v1", -- optional but strongly recommended
  }
  -- use { "rhysd/accelerated-jk", event = "BufReadPost" }
  -- use "famiu/bufdelete.nvim"

  -- use "nathom/filetype.nvim"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Debugger
  use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
  use {
    "ravenxrz/nvim-dap",
    -- commit = "f9480362549e2b50a8616fe4530deaabbc4f889b",
  }
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  -- use "mfussenegger/nvim-dap-python"    -- debug python
  -- use { "leoluz/nvim-dap-go", module = "dap-go" } -- debug golang
  use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
  use {
    "sakhnik/nvim-gdb",
    run = "./install.sh"
  }

  -- Git 插件
  use {
    "lewis6991/gitsigns.nvim",
    tag = "v0.4",
  }
  use 'sindrets/diffview.nvim'
  -- use "tanvirtin/vgit.nvim"
  -- use "tpope/vim-fugitive"

  -- UI
  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "martinsione/darkplus.nvim"
  -- use "navarasu/onedark.nvim"
  use({
    "catppuccin/nvim",
  })
  use {
    "projekt0n/github-nvim-theme",
    tag = "v0.0.4",
  }

  -- use "folke/tokyonight.nvim"


  -- 目录树
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "6abc87b1d92fc8223f1e374728ea45c848bfdf6d"
  } -- file explore
  use {
    "akinsho/bufferline.nvim", -- tab
    tag = "v1.2.0",
  }
  -- use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim" -- status line
  use "goolord/alpha-nvim" -- welcome page
  -- use "startup-nvim/startup.nvim"     -- welcome page

  -- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  -- use {
  --   "kevinhwang91/nvim-hlslens", -- highlight search
  --   disable = true,
  -- }
  use "kevinhwang91/nvim-bqf" -- better quick fix
  use "RRethy/vim-illuminate" -- highlight undercursor word   --  NOTE: 可能造成卡顿
  -- use "lewis6991/spellsitter.nvim" -- spell checker
  use "folke/todo-comments.nvim" -- todo comments
  -- use "liuchengxu/vista.vim"     -- outline
  use "simrat39/symbols-outline.nvim" -- outline
  -- use "stevearc/aerial.nvim"
  use "norcalli/nvim-colorizer.lua" -- show color
  use "folke/trouble.nvim"
  use "j-hui/fidget.nvim" -- show lsp progress
  -- use "sindrets/winshift.nvim" -- rerange window layout
  use "simeji/winresizer"
  -- litee family
  use {
    "ldelossa/litee.nvim",
    commit = "47235cb807a83af866e06ce654b28efcfe347c60"
  }
  use {
    "ldelossa/litee-calltree.nvim",
    commit = "3f3c25e584558949b1eda38ded76eade28fa5fd6"
  }

  -- tools
  -- use "cdelledonne/vim-cmake"
  use "aserowy/tmux.nvim"   -- NOTE: 可能造成卡顿
  use "ravenxrz/neovim-cmake"
  use {
    "skanehira/preview-markdown.vim",
    opt = true,
    cmd = "PreviewMarkdown",
  } -- NOTE:: glow required : https://github.com/charmbracelet/glow
  use "voldikss/vim-translator"
  use "mtdl9/vim-log-highlighting"
  use "Pocco81/HighStr.nvim"
  -- use "dstein64/vim-startuptime"
  use "ravenxrz/vim-local-history"
  -- use "henriquehbr/nvim-startup.lua"
  -- use "AckslD/nvim-neoclip.lua"
  use "vim-test/vim-test"
  use {
    "rcarriga/vim-ultest",
    run = ":UpdateRemotePlugins"
  }
  use { 'michaelb/sniprun', run = 'bash ./install.sh' }
  -- use "ravenxrz/DoxygenToolkit.vim"
  use "Pocco81/AutoSave.nvim"
  use "djoshea/vim-autoread"
  -- use "chipsenkbeil/distant.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
