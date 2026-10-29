local M = {}

---https://github.com/folke/trouble.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		TroubleIconDirectory = "Directory",
	}
end

return M
