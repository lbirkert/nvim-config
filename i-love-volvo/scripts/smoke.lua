-- Loads the colorscheme with and without transparency, and fails on an error
-- or on a link to a group that resolves to nothing.
-- Run from the repository root: nvim --headless -u NONE -l scripts/smoke.lua
vim.opt.rtp:prepend(vim.fn.getcwd())

local config = require("i-love-volvo.config")
local theme = require("i-love-volvo")

local failures = {}

for _, transparent in ipairs({ false, true }) do
	theme.setup({ transparent = transparent })
	vim.cmd.colorscheme("i-love-volvo")
	assert(vim.g.colors_name == "i-love-volvo", "colors_name not set")

	local colors = require("i-love-volvo.colors").setup(config.options)
	local groups = require("i-love-volvo.groups").setup(colors, config.options)
	for name, hl in pairs(groups) do
		if type(hl) == "string" and vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = hl })) then
			table.insert(failures, ("%s links to undefined %s"):format(name, hl))
		end
	end
end

if #failures > 0 then
	table.sort(failures)
	error(table.concat(failures, "\n"))
end

print("ok")
