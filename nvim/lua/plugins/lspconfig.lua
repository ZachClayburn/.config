return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'nvim-telescope/telescope.nvim' },
    { 'simrat39/rust-tools.nvim' },
    { 'RRethy/vim-illuminate' },
    { 'slint-ui/vim-slint' },
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

    local rt = require('rust-tools')

    local on_attach = function(client, bufnr)

      local opts = { noremap=true, silent=true, buffer = bufnr }
      vim.cmd[[let mapleader=" "]]
      if client.name == "rust_analyzer" then
        vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, opts)
        vim.keymap.set('n', 'J', rt.join_lines.join_lines, opts)
      else
        vim.lsp.handlers["textDocument/hover"]= vim.lsp.with(vim.lsp.handlers.hover, {border = border})
        vim.lsp.handlers["textDocument/signatureHelp"]= vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover,                           opts)
      end
      local list_workspace_folders = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders())) 
      end
      vim.keymap.set('n', '<leader>wl', list_workspace_folders, opts)
      vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,                     opts)
      vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,                      opts)
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,                          opts)
      vim.keymap.set('n', '<leader>e',  vim.diagnostic.open_float,                   opts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,            opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,         opts)
      vim.keymap.set('n', '<leader>f',  vim.lsp.buf.formatting,                      opts)
      vim.keymap.set('n', '<leader>a',  vim.lsp.buf.code_action,                     opts)
      -- TODO Add more keymaps. Find keymaps with :h vim.lsp

      -- require 'illuminate'.on_attach(client)
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    nvim_lsp.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      single_file_support = false,
      cmd = {'clangd-15'},
      filetypes = { 'cpp', 'c' },
    }

    nvim_lsp.cmake.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    nvim_lsp.pylsp.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              maxLineLength = 120
            }
          }
        }
      },
    }

    local home_dir = "/home/zach"
    nvim_lsp.arduino_language_server.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "arduino-language-server",
        "-cli-config", home_dir .. "/.arduino15/arduno-cli.yaml",
        "-cli", home_dir .. "/.local/bin/arduino-cli",
        "-clangd", "/usr/bin/clangd",
        "-format-conf-path", home_dir .. "/.clang-format",
        "-fqbn", "arduino:samd:mkrwifi1010"
      }
    }

    nvim_lsp.slint_lsp.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }

    -- My rust-tools config & setup have to be here to allow me to reuse my on_attach easing_function
    -- Not ideal, but oh well
    local rust_tools_opts = {
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
        -- settings = {
        --   ["rust-analyzer"] = {
        --     fmt = {
        --       overrideCommand = "cargo +nightly fmt"
        --     }
        --   }
        -- }
      },
    }
    rt.setup(rust_tools_opts)
  end
}
