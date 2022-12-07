local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

return require('packer').startup({
  function(use)
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

    use "natecraddock/telescope-zf-native.nvim"

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
  end,
  config = {
    compile_path = vim.fn.stdpath('data') .. '/site/pack/packer/plugin/compiled.lua',
  },
})
