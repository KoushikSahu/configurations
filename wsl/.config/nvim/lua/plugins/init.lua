-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use 'marko-cerovac/material.nvim'

  -- autodetect all indentation options
  use 'tpope/vim-sleuth'

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- bufferline
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- autoclose brackets
  use 'jiangmiao/auto-pairs'

  -- lsp, linters, formatters
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'jose-elias-alvarez/null-ls.nvim'
  }

  -- snippets
  use{
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  }

  -- comments
  use 'preservim/nerdcommenter'

  -- surround
  use 'tpope/vim-surround'

  -- language support
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- git integrations
  use 'kdheepak/lazygit.nvim'

  -- search help
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- debugging integrations
  use 'puremourning/vimspector'

  -- notifications
  use 'rcarriga/nvim-notify'

  -- competitive programming integration
  use {
    'xeluxee/competitest.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function() require'competitest'.setup{
      compile_command = {
        cpp       = { exec = 'g++',           args = {'-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result', '-Wconversion', '-static', '-std=c++20', '$(FNAME)'} },
      },
      run_command = {
        cpp       = { exec = './a.out' },
      },
    } end
  }

end)

