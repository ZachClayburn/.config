return {
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_variables = true
      vim.g.tokyonight_sidebars = { 'nerdtree', 'packer' }
      vim.cmd "colorscheme tokyonight"

    end
  },
  {
    'rafamadriz/neon',
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
  },
  {
    'bluz71/vim-nightfly-guicolors',
    config = function()
      -- supports lightline, vim-airline, lualine & vim-moonfly-statusline
      -- has an alacritty theme
      vim.g.nightflyCursorColor = 1
    end
  },
  {
    'nxvu699134/vn-night.nvim'
    -- supports galaxyline
  }
}
