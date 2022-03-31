" 配置文件导入
" ---------------------------------------------------------------------
" 基础使用习惯配置
runtime ./options.vim
" 插件管理
"./lua/plugins.lua
lua require('plugins')
" 按键映射
runtime ./keymaps.vim
lua require('keymaps')
" 主题管理
lua require('colorscheme')
runtime ./plugin/airline.vim
" 文件管理
" ranger
runtime ./plugin/ranger.vim
"runtime ./plugin/defx.vim
"source ~/.config/nvim/plugin/defx-icon.vim
"runtime ./plugin/defx-choosewin.vim

lua require('cmp')
lua require('lsp.init')

