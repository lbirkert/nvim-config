local util = require "zenbones.util"
local lush = require "lush"
local hsluv = lush.hsluv

local M = {}

M.light = util.palette_extend({
	bg = hsluv(39, 12, 100), -- white
	fg = hsluv(230, 30, 0), -- black
}, "light")

M.dark = util.palette_extend({
	bg = hsluv(39, 12, 0), -- black
	fg = hsluv(230, 10, 100), -- white
}, "dark")

return M
