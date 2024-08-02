return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
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
