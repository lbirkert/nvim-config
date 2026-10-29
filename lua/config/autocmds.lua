-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("user_autosave", { clear = true }),
  nested = true,
  callback = function(args)
    local buf = args.buf
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modified or not vim.bo[buf].modifiable then
      return
    end
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" or vim.fn.isdirectory(name) == 1 then
      return
    end
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! update")
    end)
  end,
})
