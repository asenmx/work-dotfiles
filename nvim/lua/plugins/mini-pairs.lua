return {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = function()
    return {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    }
  end,
  config = function(_, opts)
    require("mini.pairs").setup(opts)
  end,
}

