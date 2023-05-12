

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

void walk(lua_State *L, TSNode node, int node_pos, const char *field_name)
{
    lua_newtable(L);

    bool b;

    const char *type = ts_node_type(node);
    TSSymbol symbol_id = ts_node_symbol(node);
    TSPoint start_point = ts_node_start_point(node);
    TSPoint end_point = ts_node_end_point(node);
    TSNode parent = ts_node_parent(node);

    lua_pushstring(L, field_name);
    lua_setfield(L, -2, "field_name");

    lua_pushinteger(L, node_pos);
    lua_setfield(L, -2, "sibling_index");

    lua_pushlightuserdata(L, &node);
    lua_setfield(L, -2, "self_pointer");

    lua_pushlightuserdata(L, &parent);
    lua_setfield(L, -2, "parent_pointer");

    lua_pushstring(L, type);
    lua_setfield(L, -2, "type");

    lua_pushinteger(L, symbol_id);
    lua_setfield(L, -2, "symbol_id");

    lua_newtable(L);

    lua_pushinteger(L, start_point.row);
    lua_setfield(L, -2, "row");

    lua_pushinteger(L, start_point.column);
    lua_setfield(L, -2, "column");

    lua_setfield(L, -2, "start_point");

    lua_newtable(L);

    lua_pushinteger(L, end_point.row);
    lua_setfield(L, -2, "row");

    lua_pushinteger(L, end_point.column);
    lua_setfield(L, -2, "column");

    lua_setfield(L, -2, "end_point");

    b = ts_node_is_null(node);
    lua_pushboolean(L, b);
    lua_setfield(L, -2, "is_null");

    b = ts_node_is_named(node);
    lua_pushboolean(L, b);
    lua_setfield(L, -2, "is_named");

    b = ts_node_is_missing(node);
    lua_pushboolean(L, b);
    lua_setfield(L, -2, "is_missing");

    b = ts_node_is_extra(node);
    lua_pushboolean(L, b);
    lua_setfield(L, -2, "is_extra");

    b = ts_node_has_error(node);
    lua_pushboolean(L, b);
    lua_setfield(L, -2, "has_error");

    uint32_t c = ts_node_child_count(node);

    lua_newtable(L);

    for (int i = 0; i < c; i++)
    {
        TSNode child = ts_node_child(node, i);

        const char *name = ts_node_field_name_for_child(node, i);

        walk(L, child, i, name);

        lua_seti(L, -2, i + 1);
    }

    lua_setfield(L, -2, "children");

    // lua_newtable(L);

    // c = ts_node_named_child_count(node);

    // for (int i = 0; i < c; i++)
    // {
    //     TSNode child = ts_node_named_child(node, i);

    //     walk(L, child, i, NULL);

    //     lua_seti(L, -2, i + 1);
    // }

    // lua_setfield(L, -2, "named_children");
}

int l_ast(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);

    TSNode root_node = ts_tree_root_node(tree);

    walk(L, root_node, 0, "");

    return 1;
}

int l_with_parser_do(lua_State *L)
{
    TSParser *parser = ts_parser_new();

    lua_pushlightuserdata(L, parser);

    int retcode = lua_pcall(L, 1, LUA_MULTRET, 0); // assume we have the function as the unique argument.

    ts_parser_delete(parser);

    lua_pushboolean(L, retcode == LUA_OK);

    int n = lua_gettop(L);

    lua_rotate(L, -n, 1);

    return n;
}

int l_parser_set_language(lua_State *L)
{
    TSParser *parser = (TSParser *)lua_touserdata(L, 1);
    const char *language = lua_tostring(L, 2);

    bool set = false;

    if (strcmp(language, "json") == 0)
    {
        ts_parser_set_language(parser, tree_sitter_json());
        set = true;
    }

    lua_pushboolean(L, set);

    return 1;
}

int l_with_tree_do(lua_State *L)
{
    TSParser *parser = (TSParser *)lua_touserdata(L, 1);
    const char *source_code = lua_tostring(L, 2);

    TSTree *tree = ts_parser_parse_string(
        parser,
        NULL,
        source_code,
        strlen(source_code));

    lua_pushlightuserdata(L, tree);

    int retcode = lua_pcall(L, 1, LUA_MULTRET, 0);

    ts_tree_delete(tree);

    lua_pushboolean(L, retcode == LUA_OK);

    int n = lua_gettop(L) - 2;

    lua_rotate(L, -n, 1);

    return n;
}

int l_tree_root_node(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);

    TSNode root_node = ts_tree_root_node(tree);

    lua_pushlightuserdata(L, &root_node);

    return 1;
}

int l_ts_node_string(lua_State *L)
{
    TSNode *root_node = (TSNode *)lua_touserdata(L, 1);

    char *str = ts_node_string(*root_node);

    lua_pushstring(L, str);

    free(str);

    return 1;
}

static const struct luaL_Reg libtreesitter[] = {
    {"with_parser_do", l_with_parser_do},
    {"parser_set_language", l_parser_set_language},
    {"with_tree_do", l_with_tree_do},
    {"tree_root_node", l_tree_root_node},
    {"node_string", l_ts_node_string},
    {"ast", l_ast},
    {NULL, NULL} /* sentinel */
};

int luaopen_libtreesitter(lua_State *L)
{
    luaL_newlib(L, libtreesitter);
    return 1;
}
