return {
  'LhKipp/nvim-nu',
  opts = {
    use_lsp_features = false
  },
  dependencies = {
    'nvim-treesitter'
  },
  build = ':TSInstall nu',
}
