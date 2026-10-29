local M = {}

---https://codeberg.org/andyg/leap.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		LeapLabel = { fg = c.yellow, bold = true, nocombine = true },
		LeapMatch = { fg = c.fg1, underline = true, nocombine = true },
		LeapBackdrop = "Comment",
	}
end

return M
