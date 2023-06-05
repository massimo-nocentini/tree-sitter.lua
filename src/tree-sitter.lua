
local libc = require 'libc'
local lambda = require 'operator'
local libtreesitter = require 'libtreesitter'

local ast = libtreesitter.ast    -- take a reference to the original function.

function libtreesitter.ast (tree, src)

    local lines = src:lines (true)
    local cum_lengths = table.scan (lines, function (acc, l) return 1 + #l + acc end, 0)

    return lines, cum_lengths, ast (tree, src, cum_lengths)
end

function libtreesitter.absolute_coord_mapper (src)

    local lines = src:lines (true)
    local cum_lengths = table.scan (lines, function (acc, l) return 1 + #l + acc end, 0)

    return function (ts_point) return cum_lengths[ts_point.row] + ts_point.column end
end

function libtreesitter.with_tree_and_ast_do (parser, src, recv_f)

    return libtreesitter.with_tree_do (parser, src,
        function (tree) return recv_f (tree, libtreesitter.ast (tree, src)) end
    )

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

function libtreesitter.highlights_matches (language_def, src)
    return libtreesitter.easy_query_matches (language_def.language_handler, src, language_def.query_highlights)
end

function libtreesitter.easy_query_matches (language_handler, src, query_src)
    local matches

    libtreesitter.with_parser_do (
        function (parser)
            
            local assigned = libtreesitter.parser_set_language (parser, language_handler)
            
            assert (assigned, 'Cannot set the json language')

            libtreesitter.with_tree_do (parser, src,
                function (tree)
            
                    libtreesitter.with_query_do (tree, query_src,
                        function (query, error_id, offset)
                            
                            assert (error_id == libtreesitter.query_errors.none)

                            libtreesitter.with_tree_root_node_do (tree,
                                function (root_node)

                                    libtreesitter.with_query_cursor_do (
                                        function (cursor)
                                    
                                            matches = libtreesitter.query_matches (
                                                cursor, 
                                                query, 
                                                root_node
                                            )
                                    
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        end
    )

    return matches
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
                    local lines, cum_lengths, ast = libtreesitter.ast (tree, src)
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