return {
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope.nvim'},
      {'mfussenegger/nvim-dap'}, -- TODO Create a Config for this plugin, it is really cool!
    },
  },
  {
    'Saecki/crates.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    }
  }
}
