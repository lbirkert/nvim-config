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

local comment_fg = "#f9bb5e"
local delimiter_fg = bg == "dark" and "#b8b8b8" or "#8a8a8a"

local is_comment = function(name)
	return name == "Comment"
		or name == "SpecialComment"
		or name == "@comment"
		or name == "@comment.documentation"
		or name == "@lsp.type.comment"
end

local is_delimiter = function(name)
	return name == "Delimiter"
		or name == "markdownLinkTextDelimiter"
		or name == "@tag.delimiter"
		or name == "@constructor.lua"
		or name:find("@punctuation", 1, true) ~= nil
end

local is_line_number = function(name)
	return name == "LineNr" or name == "LineNrAbove" or name == "LineNrBelow" or name == "CursorLineNr"
end

for name, hl in pairs(spec) do
	if type(hl) == "table" then
		if is_comment(name) then
			hl.link = nil
			hl.fg = comment_fg
		elseif is_delimiter(name) or is_line_number(name) then
			hl.link = nil
			hl.fg = delimiter_fg
		end
	end
end

return spec
