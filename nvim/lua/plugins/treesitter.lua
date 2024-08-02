return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "comment",
      "cpp",
      "csv",
      "diff",
      "gdscript",
      "gdshader",
      "godot_resource",
      "json",
      "json5",
      "just",
      "llvm",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "ninja",
      "python",
      "query",
      "rst",
      "rust",
      "sql",
      "ssh_config",
      "toml",
      "tsv",
      "vim",
      "vimdoc",
      "wgsl",
      "wgsl_bevy",
      "xml",
      "yaml"
    },
    highlight = { enable = true },
    incremental_selection = { enable = false },
    indent = { enable = true }
  },
  init = function()
    vim.api.nvim_set_option_value('foldmethod', 'expr', {})
    vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})
  end
}
