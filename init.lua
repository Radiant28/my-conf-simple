local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true
vim.opt.number = true          -- Включает обычную нумерацию
vim.opt.relativenumber = true  -- Включает относительную нумерацию:
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
{ 
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "macchiato", -- Устанавливаем именно Macchiato
          background = {
            light = "latte",
            dark = "macchiato",
          },
          transparent_background = false, -- Сделайте true, если используете прозрачный терминал
          show_end_of_buffer = false,    -- Скрывает тильды (~) в конце файла
          term_colors = true,
          dim_inactive = {
            enabled = true,             -- Немного затемняет неактивные окна
            shade = "dark",
            percentage = 0.15,
          },
          no_italic = false,            -- Разрешить курсив
          no_bold = false,              -- Разрешить жирный шрифт
          styles = {
            comments = { "italic" },    -- Комментарии будут курсивом
            conditionals = { "italic" },
            loops = {},
            functions = { "bold" },
            keywords = { "italic" },
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
          },
          integrations = {
            cmp = true,                -- Автодополнение
            gitsigns = true,           -- Значки гита
            nvimtree = true,           -- Дерево файлов
            treesitter = true,         -- Улучшенная подсветка синтаксиса
            telescope = {
              enabled = true,
              style = "nvchad"         -- Красивый стиль для окна поиска
            },
            indent_blankline = {
              enabled = true,
              scope_color = "lavender", -- Цвет линии вложенности
            },
            native_lsp = {
              enabled = true,
              virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
              },
              underlines = {
                errors = { "undercurl" }, -- Красивое подчеркивание ошибок
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
              },
            },
          },
        })

        -- Применяем тему после настройки
        vim.cmd.colorscheme "catppuccin"
      end
    },
    { "nvim-tree/nvim-web-devicons" },

    -- Плагин для дерева файлов
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 30,
            side = "left",
          },
          renderer = {
            add_trailing = true,
            group_empty = true,
            highlight_opened_files = "all",
            indent_markers = {
              enable = true,
            },
            icons = {
              show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
              },
            },
          },
          filters = {
            dotfiles = false, -- показывать скрытые файлы
          },
        })

        -- Горячая клавиша для открытия/закрытия дерева: Пробел + e
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
      end,
    },

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
