return {
  'karb94/neoscroll.nvim',
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
