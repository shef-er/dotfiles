----------------------------------------
--  Plugins
----------------------------------------
local packer_packages_path = vim.fn.stdpath('data') .. '/site/pack/packer'
local packer_install_path = packer_packages_path .. '/start/packer.nvim'
local packer_bootstrap = nil
if vim.fn.isdirectory(packer_install_path) == 0 then
  packer_bootstrap = vim.fn.system(
    {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      packer_install_path
    }
  )
  vim.cmd('packadd packer.nvim')
end

require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- File explorer
  -- https://github.com/kyazdani42/nvim-tree.lua
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)



-- empty setup using defaults
require("nvim-tree").setup()

