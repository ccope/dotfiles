return {
  "josephschmitt/pj.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = { "Pj", "PjCd" },
  keys = {
    { "<leader>fp", "<cmd>Pj<cr>", desc = "Find Projects" },
  },
  opts = {},
}
