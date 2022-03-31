-- plugins
local fn = vim.fn

-- 自动安装打包器
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
  print "安装打包程序关闭并重新打开 Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- 保存 plugins.lua 文件时重新加载 neovim 的自动命令
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- 使用受保护的调用，这样就不会在第一次使用时出错
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- 让打包程序使用弹出窗口
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- 安装插件
return packer.startup(function(use)

  -- 插件
  use "wbthomason/packer.nvim" -- 包管理器
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- 主题
  use 'connorholyday/vim-snazzy'
  use {
        "vim-airline/vim-airline",
        requires = {
          "vim-airline/vim-airline-themes",
          --综合图标支持such vim-airline lightline, vim-startify
          "ryanoasis/vim-devicons"
        }
  }

  --内嵌浮动ranger插件
  use "kevinhwang91/rnvimr"

  -- 文件管理插件，类似与ranger
  use {
  	  "Shougo/defx.nvim",
	  requires = {
		"kristijanhusak/defx-icons", -- dexf文件管理图标支持
		"t9md/vim-choosewin" -- 窗口选择器,可以让defx使用i打开文件
	  }
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  use 'iamcco/markdown-preview.nvim'


  -- 克隆 packer.nvim 后自动设置你的配置
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
