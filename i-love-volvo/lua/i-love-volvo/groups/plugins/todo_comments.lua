local M = {}

---https://github.com/folke/todo-comments.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	-- TODO defaults to DiagnosticInfo; match the theme's own Todo instead
	return {
		TodoBgTODO = { fg = c.black, bg = c.yellow, bold = opts.bold },
		TodoFgTODO = { fg = c.yellow },
		TodoSignTODO = { fg = c.yellow },
	}
end

return M
