local M = {}

---https://github.com/folke/noice.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		NoiceCmdlineIcon = { fg = c.yellow },
		NoiceCmdlinePopupTitle = { fg = c.black, bg = c.yellow },
		NoiceCmdlinePopupBorder = { fg = c.border },
		NoiceCmdlinePopupBorderSearch = { fg = c.border },
		NoiceConfirmBorder = { fg = c.border },
		NoiceLspProgressSpinner = { fg = c.yellow },
	}
end

return M
