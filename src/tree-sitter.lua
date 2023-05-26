
local libc = require 'libc'
local lambda = require 'operator'
local libtreesitter = require 'libtreesitter'

local ast = libtreesitter.ast    -- take a reference to the original function.

function libtreesitter.ast (tree, src)

    local lines = src:lines (true)
    local cum_lengths = table.scan (lines, function (acc, l) return 1 + #l + acc end, 0)

    return ast (tree, src, cum_lengths)
end

function libtreesitter.walk (ast_tbl, w)

    local function W (n)
        
        w (
            n.type,
            n.field_name,
            n.is_named,
            n.absolute_start_end_pair[1] + 1,
            n.absolute_start_end_pair[2],
            n
        )

        for _, c in ipairs (n.children) do W (c) end
    end

    return W (ast_tbl)

end

local function all_in_one_shot (lang, src, f)

    local flag, v = libtreesitter.with_parser_do (
        function (parser)
            local set = libtreesitter.parser_set_language (parser, lang)
            assert (set, 'Cannot set the given language.')
    
            local f, v = libtreesitter.with_tree_do (
                parser,
                src,
                function (tree) 
                    local ast = libtreesitter.ast (tree, src)
                    return libtreesitter.walk (ast, f)
                end
            )
            
            assert (f, v)

            return v
        end
    )

    assert (flag, v)

    return v
end

local mt = {}

function mt.__call (recv_tbl, ...) return all_in_one_shot (...) end

setmetatable (libtreesitter, mt)

return libtreesitter