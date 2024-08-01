vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
g.mapleader = " "
g.maplocalleader = "\\"

local opt = require('opt')

local indent = 4
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', indent)
opt('b', 'tabstop', indent)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('g', 'mouse', 'a')
opt('g', 'scrolloff', 10)
opt('w', 'foldmethod', 'syntax')
opt('g', 'termguicolors', true)
opt('g', 'showmode', false)
opt('w', 'list', true)
opt('g', 'listchars', 'eol:,tab:→ ,trail:,extends:ﲖ,precedes:ﲕ')
opt('g', 'showbreak', '↪ ')
opt('g', 'wrap', false)
opt('g', 'undofile', true)
opt('g', 'ignorecase', true)
opt('g', 'smartcase', true)
require("config.lazy")

local map = require('map')
cmd[[let mapleader=" "]]

map('n', '<C-n>', ':set relativenumber!<CR>', {silent = true})

map('t', '<Esc>', '<C-\\><C-n>')

map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')
map('n', '<A-h>', '<C-w>h')
map('t',  '<A-h>', '<C-\\><C-N><C-w>h')
map('t',  '<A-j>', '<C-\\><C-N><C-w>j')
map('t',  '<A-k>', '<C-\\><C-N><C-w>k')
map('t',  '<A-l>', '<C-\\><C-N><C-w>l')

g.python3_host_prog = '/usr/bin/python3'

-- gui/neovide settings
opt('g', 'guifont', 'JetBrainsMono Nerd Font' )
