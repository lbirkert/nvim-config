local M = {}

---https://github.com/HiPhish/rainbow-delimiters.nvim
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		RainbowDelimiterRed = { fg = c.red },
		RainbowDelimiterYellow = { fg = c.yellow },
		RainbowDelimiterBlue = { fg = c.niagara },
		RainbowDelimiterOrange = { fg = c.brown },
		RainbowDelimiterGreen = { fg = c.green },
		RainbowDelimiterViolet = { fg = c.wisteria },
		RainbowDelimiterCyan = { fg = c.quartz },
	}
end

return M
