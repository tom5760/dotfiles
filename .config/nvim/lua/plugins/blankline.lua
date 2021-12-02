require('indent_blankline').setup {
  char = '┊',

  filetype_exclude = { 'help', 'packer' },
  buftype_exclude  = { 'terminal', 'nofile' },

  use_treesitter = true,

  show_trailing_blankline_indent = false,
}
