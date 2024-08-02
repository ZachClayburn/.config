return {
  'preservim/nerdtree',
  dependencies = {
    {'ryanoasis/vim-devicons'},
    {'Xuyuanp/nerdtree-git-plugin'}
  },
  init = function()
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
