
local treesitter = require 'tree-sitter'

local syntax = treesitter.parse [[

    [1, null]

]]

print (syntax)