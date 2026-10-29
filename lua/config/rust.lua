local M = {}

function M.is_enabled()
  return vim.lsp.is_enabled("rust_analyzer")
end

function M.toggle()
  local enable = not M.is_enabled()
  local ok, err = pcall(vim.lsp.enable, "rust_analyzer", enable)
  if not ok then
    vim.notify("rust-analyzer toggle failed: " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  vim.notify(
    enable and "rust-analyzer enabled" or "rust-analyzer disabled (cargo fmt on save)",
    enable and vim.log.levels.INFO or vim.log.levels.WARN
  )
end

return M
