-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Add plugins
local f =  require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'

  --use 'airblade/vim-gitgutter'
  use { 'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        numhl = false,
        linehl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,

          ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
          ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
        },
        watch_index = {
          interval = 1000
        },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        use_internal_diff = true,  -- If luajit is present
      }
    end
  }

  use { 'preservim/nerdcommenter',
    config = function()
      vim.g.NERDCompactSexyComs = true
      vim.g.NERDSpaceDelims = true
      vim.g.NERDCommentEmptyLines = true
      vim.g.NERDDefaultAlign = 'left'
      vim.g.NERDTrimTrailingWhitespace = true
    end
  }

  use 'jiangmiao/auto-pairs'

  use{ 'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_variables = true
      vim.g.tokyonight_sidebars = { 'nerdtree', 'packer' }
      vim.cmd "colorscheme tokyonight"
    end
  }

  use { 'hoob3rt/lualine.nvim',
    requires = { {'kyazdani42/nvim-web-devicons', opt = false}, {'ryanoasis/vim-devicons', opt = false} },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          section_separators = {'', ''},
          component_separators = {'', ''},
          -- section_separators = {'', ''},
          -- component_separators = {'', ''},
          -- section_separators = {' ', '  '},
          -- component_separators = {' ', ' '},
          icons_enabled = true,
        },
        sections = {
        lualine_a = { {'mode', upper = true} },
        lualine_b = { {'branch', icon = ''} },
        lualine_c = { {'filename', file_status = true, symbols = {modified = '  ', readonly = '  ' }} },
        lualine_x = { {
            'diagnostics',
            sources = { 'ale', 'nvim_lsp' },
            symbols = {
              error = ' ﮊ ',
              warn =  ' ﮻ ',
              info = '  '
            }
          } },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
      },
      inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
      },
      tabline = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
      },
      extensions = { 'fugitive', 'nerdtree' }
      }
    end
  }

  use { 'dense-analysis/ale',
    opt = false,
    -- setup = function()
    --   -- Called before plugin loaded
    -- end,
    config = function()
      -- Called after plugin loaded
      vim.g.ale_lua_luacheck_options = '--globals vim'
      vim.g.ale_detail_to_floating_preview = true
      vim.g.ale_floating_preview = true
      vim.g.ale_sign_error = 'ﮊ'
      vim.g.ale_sign_warning =''
      vim.g.ale_sign_info = ''
    end
  }

  use { 'preservim/nerdtree',
    requires = {
      {'ryanoasis/vim-devicons', opt = false},
      {'Xuyuanp/nerdtree-git-plugin', opt = false}
    },
    config = function()
      vim.cmd[[let mapleader=" "]]
      local map = require('map')
      local opts = { noremap=true, silent=true }
      map('n', '<Leader>nt', ':NERDTreeToggle<CR>', opts)
      map('n', '<Leader>nf', ':NERDTreeFocus<CR>', opts)
      map('n', '<Leader>nr', ':NERDTreeRefreshRoot<CR>', opts)
      map('n', '<Leader>nc', ':NERDTreeCWD<CR>', opts)
      map('n', '<C-f>', ':NERDTreeFind<CR>', opts)

      -- Exit Vim if NERDTree is the only window remaining in the only tab.
      vim.api.nvim_command([[
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      ]])
      -- Close the tab if NERDTree is the only window remaining in it.
      vim.api.nvim_command([[
      autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      ]])
      -- Start NERDTree when Vim starts with a directory argument.
      vim.api.nvim_command([[
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
          \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
      ]])
    end
  }

  use 'tpope/vim-fugitive'

  use 'tpope/vim-git'

  use 'tpope/vim-sensible'

  use 'tpope/vim-surround'

  use 'fhill2/floating.nvim'

  use 'jeffkreeftmeijer/vim-numbertoggle'

  use 'sheerun/vim-polyglot'

  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indentLine_char = '│'
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    opt = false,
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = { enabled = true },
        incremental_selection = { enabled = true },
        indent = { enabled = true }
      }
    end
  }

  use { 'neovim/nvim-lspconfig',
    config = function()
      local nvim_lsp = require('lspconfig')

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local opts = { noremap=true, silent=true }
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        -- TODO Add more keymaps. Find keymaps with :h vim.lsp
      end

      local servers = { 'clangd', 'cmake' }
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup { on_attach = on_attach }
      end
    end
  }

  use { 'nvim-lua/completion-nvim',
    requires = {
      { 'neovim/nvim-lspconfig' }
    },
    config = function()
      -- TODO Add extra completion sources and configure everything
      vim.cmd[[autocmd BufEnter * lua require'completion'.on_attach()]]
    end
  }

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-project.nvim'}
    },
    config = function()
      vim.cmd[[let mapleader=" "]]
      local map = require('map')
      local mapOpts = {silent=true, noremap=true}
      local telescope = require('telescope')
      map('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], mapOpts)
      map('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], mapOpts)
      map('n', '<Leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], mapOpts)
      telescope.load_extension('project')
      map('n', '<Leader>fp', [[<cmd>lua require'telescope'.extensions.project.project{}<cr>]], mapOpts)
    end
  }

  use { 'nvim-telescope/telescope-project.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require'telescope'.load_extension('project')
    end
  }

  use { 'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end
  }

  use 'junegunn/vim-easy-align'

end)

return f
