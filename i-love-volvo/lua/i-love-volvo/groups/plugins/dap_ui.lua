local M = {}

---https://github.com/rcarriga/nvim-dap-ui
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		DapUIFloatBorder = { fg = c.border, bg = c.bg_float },
		DapUIWatchesError = { fg = c.diag.error },
		DapUIPlayPause = { fg = c.green },
		DapUIStop = { fg = c.red },
	}
end

return M
