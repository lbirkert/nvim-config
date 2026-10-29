local M = {}

---https://github.com/folke/flash.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		-- The default, Substitute, renders the same as the FlashMatch under it
		FlashLabel = { fg = c.yellow, bold = opts.bold, nocombine = true },
	}
end

return M
