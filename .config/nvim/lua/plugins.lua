local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compile_path = vim.fn.stdpath('data') .. '/site/pack/packer/plugin/compiled.lua'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local function setup()
  -- manage packer with packer
  use 'wbthomason/packer.nvim'

  -- incremental file parsing
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- additional text objects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- file finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- color scheme
  use {
    'npxbr/gruvbox.nvim',
    requires = { 'rktjmp/lush.nvim' }
  }

  -- language-server-protocol setup
  use 'neovim/nvim-lspconfig'

  -- file tree window
  use 'scrooloose/nerdtree'

  -- wiki editor
  use 'vimwiki/vimwiki'

  -- indent guide
  use 'lukas-reineke/indent-blankline.nvim'

  -- toggle comments
  use 'terrortylor/nvim-comment'

  if packer_bootstrap then
    require('packer').sync()
  end
end

local config = {
  compile_path = compile_path,
}

require('packer').startup({ setup, config = config })
