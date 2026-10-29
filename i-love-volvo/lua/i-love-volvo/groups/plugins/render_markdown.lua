local M = {}

---https://github.com/MeanderingProgrammer/render-markdown.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	local groups = {
		RenderMarkdownQuote = { fg = c.fg_muted },
		RenderMarkdownChecked = { fg = c.diag.ok },
	}

	for level = 1, 6 do
		groups["RenderMarkdownH" .. level .. "Bg"] = { bg = c.bg_highlight }
	end

	return groups
end

return M
