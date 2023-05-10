

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <time.h>
#include <math.h>
#include <tree_sitter/api.h>
#include <tree_sitter/json.h>

int l_parse(lua_State *L)
{

    const char *source_code = lua_tostring(L, 1);

    // Create a parser.
    TSParser *parser = ts_parser_new();

    // Set the parser's language (JSON in this case).
    ts_parser_set_language(parser, tree_sitter_json());

    // Build a syntax tree based on source code stored in a string.
    TSTree *tree = ts_parser_parse_string(
        parser,
        NULL,
        source_code,
        strlen(source_code));

    // Get the root node of the syntax tree.
    TSNode root_node = ts_tree_root_node(tree);

    // Get some child nodes.
    // TSNode array_node = ts_node_named_child(root_node, 0);
    // TSNode number_node = ts_node_named_child(array_node, 0);

    // Check that the nodes have the expected types.
    // assert(strcmp(ts_node_type(root_node), "document") == 0);
    // assert(strcmp(ts_node_type(array_node), "array") == 0);
    // assert(strcmp(ts_node_type(number_node), "number") == 0);

    // Check that the nodes have the expected child counts.
    // assert(ts_node_child_count(root_node) == 1);
    // assert(ts_node_child_count(array_node) == 5);
    // assert(ts_node_named_child_count(array_node) == 2);
    // assert(ts_node_child_count(number_node) == 0);

    // Print the syntax tree as an S-expression.
    char *string = ts_node_string(root_node);

    lua_pushstring(L, string);

    // Free all of the heap-allocated memory.
    free(string);
    ts_tree_delete(tree);
    ts_parser_delete(parser);

    return 1;
}

static const struct luaL_Reg libtreesitter[] = {
    {"parse", l_parse},

    {NULL, NULL} /* sentinel */
};

int luaopen_libtreesitter(lua_State *L)
{
    luaL_newlib(L, libtreesitter);
    return 1;
}
