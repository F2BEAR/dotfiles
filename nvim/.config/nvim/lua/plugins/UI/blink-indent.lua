return {
  'saghen/blink.indent',
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    static = {
      enabled = true,
      char = '│',
      whitespace_char = nil,
      priority = 1,
      highlights = { 'BlinkIndent' }
    },
  },
}
