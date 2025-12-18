return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  opts = {
    to_clipboard = true,
    line_offset = function(args)
      return args.line1
    end,
  },
}
