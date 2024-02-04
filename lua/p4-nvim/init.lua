local p4 = require("p4-nvim.p4")

local M = {}

M.checkout = p4.checkout
M.add = p4.add

return M
