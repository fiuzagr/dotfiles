-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ba", function()
  Snacks.bufdelete.all()
end, { desc = "Delete all Buffers" })

vim.keymap.set(
  "n",
  "<leader>bw",
  "<cmd>w<cr>",
  { noremap = true, desc = "Save Buffer" }
)
