

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

int l_with_parsed_tree_do(lua_State *L)
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
    {"with_parsed_tree_do", l_with_parsed_tree_do},
    {"tree_root_node", l_tree_root_node},
    {"node_string", l_ts_node_string},
    {NULL, NULL} /* sentinel */
};

int luaopen_libtreesitter(lua_State *L)
{
    luaL_newlib(L, libtreesitter);
    return 1;
}
