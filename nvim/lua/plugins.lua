-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Add plugins
local f =  require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'

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

  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  use { 'NTBBloodbath/galaxyline.nvim',
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require'galaxyline.themes.eviline'
    end,
  }

  use { 'alvarosevilla95/luatab.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('luatab').setup({})
    end
  }

  use { 'dense-analysis/ale',
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

      vim.g.ale_linters = {
        rust = {'cargo'},
      }
      vim.g.ale_disable_lsp = 1
    end
  }

  use { 'preservim/nerdtree',
    requires = {
      {'ryanoasis/vim-devicons'},
      {'Xuyuanp/nerdtree-git-plugin'}
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

  use { 'tpope/vim-fugitive' }

  use { 'tpope/vim-git' }

  use 'tpope/vim-sensible'

  use 'tpope/vim-surround'

  use { 'jeffkreeftmeijer/vim-numbertoggle' }

  use { 'sheerun/vim-polyglot' }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_end_of_line = false,
      }
      local map = require('map')
      local opts = { noremap=true, silent=true }
      map('n', 'zo', 'zo:IndentBlanklineRefresh<CR>', opts)
      map('n', 'zO', 'zO:IndentBlanklineRefresh<CR>', opts)
      map('n', 'zi', 'zi:IndentBlanklineRefresh<CR>', opts)
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = { enabled = vim.g.vscode == nil },
        incremental_selection = { enabled = true },
        indent = { enabled = true }
      }
    end
  }

  use { 'neovim/nvim-lspconfig',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'nvim-telescope/telescope.nvim' },
      { 'simrat39/rust-tools.nvim' },
    },
    config = function()
      local nvim_lsp = require('lspconfig')

      local border = {
        {"╭", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╮", "FloatBorder"},
        {"│", "FloatBorder"},
        {"╯", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╰", "FloatBorder"},
        {"│", "FloatBorder"},
      }

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        vim.lsp.handlers["textDocument/hover"]= vim.lsp.with(vim.lsp.handlers.hover, {border = border})
        vim.lsp.handlers["textDocument/signatureHelp"]= vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})

        local opts = { noremap=true, silent=true }
        vim.cmd[[let mapleader=" "]]
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        -- TODO Add more keymaps. Find keymaps with :h vim.lsp
      end

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      nvim_lsp.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {'clangd-13'}
      }

      nvim_lsp.cmake.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      nvim_lsp.pylsp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local home_dir = "/home/zach"
      nvim_lsp.arduino_language_server.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-cli-config", home_dir .. "/.arduino15/arduno-cli.yaml",
          "-cli", home_dir .. "/.local/bin/arduino-cli",
          "-clangd", "/usr/bin/clangd-13",
          "-format-conf-path", home_dir .. "/.clang-format",
          "-fqbn", "arduino:samd:mkrwifi1010"
        }
      }

      -- My rust-tools config & setup have to be here to allow me to reuse my on_attach easing_function
      -- Not ideal, but oh well
      local rust_tools_opts = {
        server = {
          on_attach = on_attach
        }
      }
      require('rust-tools').setup(rust_tools_opts)
    end
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'windwp/nvim-autopairs' },
      { 'Saecki/crates.nvim' },
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, {
            { name = 'nvim_lua' },
            { name = 'crates' },
            { name = 'buffer' },
          }),
        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        }
      }
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
      map('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], mapOpts)
      map('n', '<Leader>fw', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], mapOpts)
      telescope.load_extension('project')
      map('n', '<Leader>fp', [[<cmd>lua require'telescope'.extensions.project.project{}<cr>]], mapOpts)
    end
  }

  use { 'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup{
        mappings = {},
        hide_cursor = true,
        stop_eof = true,
        use_local_scrolloff = false,
        respect_scrolloff = true,
        cursor_scrolls_alone = true,
        easing_function = 'sine',
        pre_hook = nil,
        post_hook = nil,
      }
      local mappings = {}
      mappings['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '300'}}
      mappings['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '300'}}
      mappings['<C-Up>']   = {'scroll', {'-0.10', 'false', '100'}}
      mappings['<C-Down>'] = {'scroll', { '0.10', 'false', '100'}}
      mappings['zz'] = {'zz', {'250'}}
      mappings['zt'] = {'zt', {'250'}}
      mappings['zb'] = {'zb', {'250'}}
      require('neoscroll.config').set_mappings(mappings)
    end
  }

  use 'junegunn/vim-easy-align'

  use { 'simrat39/rust-tools.nvim',
    requires = {
      {'neovim/nvim-lspconfig'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope.nvim'},
      {'mfussenegger/nvim-dap'}, -- TODO Create a Config for this plugin, it is really cool!
    },
    config = function()
    end
  }

  use { 'Saecki/crates.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- Color schemes
  use { 'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_variables = true
      vim.g.tokyonight_sidebars = { 'nerdtree', 'packer' }
      vim.cmd "colorscheme tokyonight"

    end
  }

  use { 'rafamadriz/neon',
    config = function()
      -- Supports lualine
      vim.g.neon_style = 'default'
      vim.g.neon_italic_comment = true
      vim.g.neon_italic_keyword = true
      vim.g.neon_italic_boolean = true
      vim.g.neon_italic_function = true
      vim.g.neon_italic_variable = true
      vim.g.neon_bold = true
      vim.g.neon_transparent = false
    end
  }

  use { 'bluz71/vim-nightfly-guicolors',
    config = function()
      -- supports lightline, vim-airline, lualine & vim-moonfly-statusline
      -- has an alacritty theme
      vim.g.nightflyCursorColor = 1
    end
  }

  use { 'nxvu699134/vn-night.nvim'
    -- supports galaxyline
  }

end)

return f
