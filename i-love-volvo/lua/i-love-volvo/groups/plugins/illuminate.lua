local M = {}

---https://github.com/RRethy/vim-illuminate
---@param c ILoveVolvoColors
---@param opts ILoveVolvoConfig
---@return ILoveVolvoHighlights
function M.get(c, opts)
	return {
		IlluminatedWordText = "LspReferenceText",
		IlluminatedWordRead = "LspReferenceRead",
		IlluminatedWordWrite = "LspReferenceWrite",
	}
end

return M
