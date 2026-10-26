local generator = require "zenbones.specs"
local lush = require "lush"
local bg = vim.o.background
local p = require("zenbones.palette")[bg]

local spec = generator.generate(p, bg, generator.get_global_config("zenbones", bg))

if bg == "dark" then
	local white = lush.hsluv(0, 0, 100)
	local keep_color = {
		-- intentionally dim
		SnacksIndent = true,
		SnacksIndentScope = true,
		IblIndent = true,
		IblScope = true,
		IndentLine = true,
		IndentLineCurrent = true,
		-- severity bases, DiagnosticError/DiagnosticWarn link these
		Error = true,
		ErrorMsg = true,
		WarningMsg = true,
	}
	local keep_prefixes = { "Diagnostic", "Lsp", "BlinkCmp", "CmpItem", "Notify" }
	local keep = function(name)
		if keep_color[name] then
			return true
		end
		for _, prefix in ipairs(keep_prefixes) do
			if name:sub(1, #prefix) == prefix then
				return true
			end
		end
		return false
	end
	-- kept groups that link to a whitened group resolve to white at compile
	-- time; snapshot their resolved attrs so the link can be broken below
	local kept_attrs = {}
	for name, hl in pairs(spec) do
		if type(hl) == "table" and keep(name) and hl.link and not keep(hl.link) then
			local attrs = {}
			for _, key in ipairs { "fg", "bg", "sp", "gui" } do
				if hl[key] ~= nil then
					attrs[key] = hl[key]
				end
			end
			kept_attrs[name] = attrs
		end
	end
	for name, hl in pairs(spec) do
		if type(hl) == "table" and hl.fg ~= nil and not keep(name) then
			hl.fg = white
		end
	end
	for name, attrs in pairs(kept_attrs) do
		local hl = spec[name]
		hl.link = nil
		for key, value in pairs(attrs) do
			hl[key] = value
		end
	end
	for name, gray in pairs {
		BlinkCmpLabelDetail = "#aaaaaa",
		BlinkCmpLabelDescription = "#aaaaaa",
		BlinkCmpSource = "#aaaaaa",
		LspInlayHint = "#aaaaaa",
	} do
		if spec[name] then
			spec[name].link = nil
			spec[name].fg = gray
		end
	end
end

return spec
