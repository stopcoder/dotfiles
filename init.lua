vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = ","
-- let nvim_tree select the current file in the tree
vim.g.nvim_tree_respect_buf_cwd = 1

-- no expand tab input with spaces characters
vim.opt.expandtab = false
-- syntax aware indentations for newline inserts
vim.opt.smartindent = true
-- num of space characters per tab
vim.opt.tabstop = 4
-- spaces per indentation level
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.modeline = false
vim.cmd([[autocmd FileType * set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab]])

-- no eol at the end of file
vim.opt.fixeol = false

-- enable spelling check
vim.opt.spell = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
		config = function()
			require "options"
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {
				actions = {
					change_dir = {
						enable = false,
					}
				}
			}
		end,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end
	},
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons'     -- optional
		}
	},
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = {
			'nvimdev/lspsaga.nvim'

		}
	},
	-- { "rebelot/kanagawa.nvim" },
	{ 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
	{ 'kamykn/spelunker.vim', lazy = false },
	{ 'tpope/vim-vinegar', lazy = false },
	{ 'tpope/vim-fugitive', lazy = false },
	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- require("kanagawa").load("wave")
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require "nvchad.autocmds"

vim.schedule(function()
	require "mappings"
end)

-- config typescript-language-server
-- require'lspconfig'.tsserver.setup{}
-- config eslint lsp
require'lspconfig'.eslint.setup{}

-- toggle highlighting the cursor line
vim.keymap.set('n', '<leader>,', ':set cursorline!<cr>', {})

-- map the delete, yank, paste to the 'p' register
vim.keymap.set('v', '<leader>y', '"py', {})
vim.keymap.set('n', '<leader>p', '"pp', {})
vim.keymap.set('n', '<leader>P', '"pP', {})
vim.keymap.set('v', '<leader>d', '"pd', {})

-- comment out the current line
vim.keymap.set('n', '<leader>/', '0wi// <esc>', {})

-- reselect last pasted (or changed) text
vim.keymap.set('n', 'gV', '`[v`]', {})

-- switch between buffers
vim.keymap.set('n', '<leader>b', '<cmd>bp<CR>', {})
vim.keymap.set('n', '<leader>f', '<cmd>bn<CR>', {})
vim.keymap.set('n', '<leader>g', '<cmd>e#<CR>', {})

-- fzf-lua binds to key ctrl+p
vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<c-B>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })

-- fzf-lua global search the current word
vim.keymap.set("n", "<leader>sd", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
vim.keymap.set("n", "<leader>gs", "<cmd>lua require('fzf-lua').grep()<CR>", { silent = true })

-- fzf-lua resume last search
vim.keymap.set("n", "<c-X>", "<cmd>lua require('fzf-lua').resume()<CR>", { silent = true })

-- disable mouse
vim.opt.mouse = ""
