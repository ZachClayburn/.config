return {
  'dense-analysis/ale',
  -- setup = function()
  --   -- Called before plugin loaded
  -- end,
  init = function()
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
