

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <time.h>
#include <math.h>
#include <tree_sitter/api.h>

// Use conditional compilation under Windows.
#define HIGHLIGHTS_JSON_FILEPATH "/usr/local/share/lua/5.4/tree-sitter/highlights-json.scm"

TSLanguage *tree_sitter_json();

void walk(lua_State *L, const char *src, const TSLanguage *lang, TSNode node, int node_pos, const char *field_name)
{
    lua_newtable(L);

    bool b;

    const char *type = ts_node_type(node);
    TSSymbol symbol_id = ts_node_symbol(node);
    TSPoint start_point = ts_node_start_point(node);
    TSPoint end_point = ts_node_end_point(node);
    // TSNode parent = ts_node_parent(node);

    lua_pushstring(L, field_name);
    lua_setfield(L, -2, "field_name");

    lua_pushinteger(L, node_pos);
    lua_setfield(L, -2, "sibling_index");

    // lua_pushlightuserdata(L, &node);
    // lua_setfield(L, -2, "self_pointer");

    // lua_pushlightuserdata(L, &parent);
    // lua_setfield(L, -2, "parent_pointer");

    lua_pushstring(L, type);
    lua_setfield(L, -2, "type");

    lua_pushinteger(L, symbol_id);
    lua_setfield(L, -2, "symbol_id");

    const char *symbol_name = ts_language_symbol_name(lang, symbol_id);
    lua_pushstring(L, symbol_name);
    lua_setfield(L, -2, "symbol_name");

    lua_geti(L, 3, start_point.row + 1);
    lua_geti(L, 3, end_point.row + 1);
    int start = lua_tointeger(L, -2) + start_point.column;
    int end = lua_tointeger(L, -1) + end_point.column;
    lua_pop(L, 2);

    lua_newtable(L);
    lua_pushinteger(L, start);
    lua_seti(L, -2, 1);

    lua_pushinteger(L, end);
    lua_seti(L, -2, 2);

    lua_setfield(L, -2, "absolute_start_end_pair");

    int n = end - start;
    char *token = (char *)malloc(sizeof(char) * n + 1);
    strncpy(token, src + start, n);
    token[n] = '\0';
    lua_pushstring(L, token);
    lua_setfield(L, -2, "content");
    free(token);

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

        walk(L, src, lang, child, i, name);

        lua_seti(L, -2, i + 1);
    }

    lua_setfield(L, -2, "children");
}

int l_language_symbols(lua_State *L)
{
    TSLanguage *lang = (TSLanguage *)lua_touserdata(L, 1);

    uint32_t c = ts_language_symbol_count(lang);

    lua_newtable(L);

    for (int i = 0; i < c; i++)
    {
        const char *name = ts_language_symbol_name(lang, i);
        TSSymbolType t = ts_language_symbol_type(lang, i);

        lua_newtable(L);

        lua_pushstring(L, name);
        lua_setfield(L, -2, "name");

        if (t == TSSymbolTypeRegular)
        {
            lua_pushstring(L, "regular");
        }
        else if (t == TSSymbolTypeAnonymous)
        {
            lua_pushstring(L, "anonymous");
        }
        else
        {
            lua_pushstring(L, "auxiliary");
        }
        lua_setfield(L, -2, "type");

        lua_seti(L, -2, i + 1);
    }

    return 1;
}

int l_tree_language(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);

    const TSLanguage *lang = ts_tree_language(tree);

    lua_pushlightuserdata(L, (void *)lang);

    return 1;
}

int l_ast(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);
    const char *src = lua_tostring(L, 2);

    TSNode root_node = ts_tree_root_node(tree);

    const TSLanguage *lang = ts_tree_language(tree);

    walk(L, src, lang, root_node, 0, "");

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
    TSLanguage *language = (TSLanguage *)lua_touserdata(L, 2);

    bool assigned = ts_parser_set_language(parser, language);

    lua_pushboolean(L, assigned);

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

int l_with_tree_root_node_do(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);

    TSNode root_node = ts_tree_root_node(tree);

    lua_pushlightuserdata(L, &root_node);

    int retcode = lua_pcall(L, 1, LUA_MULTRET, 0);

    lua_pushboolean(L, retcode == LUA_OK);

    int n = lua_gettop(L) - 1;

    lua_rotate(L, -n, 1);

    return n;
}

int l_node_string(lua_State *L)
{
    TSNode *root_node = (TSNode *)lua_touserdata(L, 1);

    char *str = ts_node_string(*root_node);

    lua_pushstring(L, str);

    free(str);

    return 1;
}

int l_with_query_do(lua_State *L)
{
    TSTree *tree = (TSTree *)lua_touserdata(L, 1);
    const char *query_source = lua_tostring(L, 2);

    const TSLanguage *language = ts_tree_language(tree);

    uint32_t error_offset;
    TSQueryError error_type;

    TSQuery *query = ts_query_new(
        language,
        query_source,
        strlen(query_source),
        &error_offset,
        &error_type);

    lua_pushlightuserdata(L, query);
    lua_pushinteger(L, error_type);
    lua_pushinteger(L, error_offset);

    int retcode = lua_pcall(L, 3, LUA_MULTRET, 0);

    ts_query_delete(query);

    lua_pushboolean(L, retcode == LUA_OK);

    int n = lua_gettop(L) - 2;

    lua_rotate(L, -n, 1);

    return n;
}

int l_query_matches(lua_State *L)
{
    TSQueryCursor *cursor = (TSQueryCursor *)lua_touserdata(L, 1);
    TSQuery *query = (TSQuery *)lua_touserdata(L, 2);
    TSNode *node = (TSNode *)lua_touserdata(L, 3);

    int abs_coord_func_index = 4;
    luaL_argexpected(L, lua_type(L, abs_coord_func_index) == LUA_TFUNCTION, abs_coord_func_index, "function");

    ts_query_cursor_exec(cursor, query, *node);

    TSQueryMatch match;
    TSQueryCapture capture;
    TSNode captured_node;
    TSPoint point;
    int len;
    uint32_t length;

    int type, row, column;

    lua_newtable(L);

    while (ts_query_cursor_next_match(cursor, &match))
    {
        for (int i = 0; i < match.capture_count; i++)
        {
            capture = match.captures[i];

            captured_node = capture.node;

            const char *capture_name = ts_query_capture_name_for_id(
                query,
                capture.index,
                &length);

            type = lua_getfield(L, -1, capture_name);

            if (type == LUA_TNIL)
            {
                lua_pop(L, 1);
                lua_newtable(L);
                lua_pushvalue(L, -1);
                lua_setfield(L, -3, capture_name);
            }

            lua_len(L, -1);
            len = lua_tointeger(L, -1);
            lua_pop(L, 1);

            lua_newtable(L);

            point = ts_node_start_point(captured_node);

            lua_createtable(L, 0, 2);

            row = point.row + 1;
            lua_pushinteger(L, row);
            lua_setfield(L, -2, "row");

            column = point.column + 1;
            lua_pushinteger(L, column);
            lua_setfield(L, -2, "column");

            lua_setfield(L, -2, "start_point");

            point = ts_node_end_point(captured_node);

            lua_createtable(L, 0, 2);

            row = point.row + 1;
            lua_pushinteger(L, row);
            lua_setfield(L, -2, "row");

            column = point.column;
            lua_pushinteger(L, column);
            lua_setfield(L, -2, "column");

            lua_setfield(L, -2, "end_point");

            lua_createtable(L, 0, 2); // for the absolute coordinates.

            lua_pushvalue(L, abs_coord_func_index);
            lua_getfield(L, -3, "start_point");
            lua_call(L, 1, 1);

            lua_setfield(L, -2, "from");

            lua_pushvalue(L, abs_coord_func_index);
            lua_getfield(L, -3, "end_point");
            lua_call(L, 1, 1);

            lua_setfield(L, -2, "to");

            lua_setfield(L, -2, "absolute");

            // const char *str_value = ts_query_string_value_for_id(
            //     query,
            //     match.pattern_index,
            //     &length);

            // lua_pushstring(L, str_value);
            // lua_setfield(L, -2, "query_string_value");

            lua_seti(L, -2, len + 1);

            lua_pop(L, 1);
        }
    }

    return 1;
}

int l_with_query_cursor_do(lua_State *L)
{
    TSQueryCursor *cursor = ts_query_cursor_new();

    lua_pushlightuserdata(L, cursor);

    int retcode = lua_pcall(L, 1, LUA_MULTRET, 0);

    ts_query_cursor_delete(cursor);

    lua_pushboolean(L, retcode == LUA_OK);

    lua_rotate(L, 1, 1);

    return LUA_MULTRET;
}

void add_language_json(lua_State *L)
{

    TSLanguage *lang = tree_sitter_json();

    lua_newtable(L);

    lua_pushlightuserdata(L, lang);
    lua_setfield(L, -2, "language_handler");

    FILE *fptr;

    fptr = fopen(HIGHLIGHTS_JSON_FILEPATH, "r");

    if (fptr != NULL)
    {

        char c;

        luaL_Buffer b;
        luaL_buffinit(L, &b);

        while ((c = fgetc(fptr)) != EOF)
        {
            luaL_addchar(&b, c);
        }

        luaL_pushresult(&b);
    }
    else
    {
        lua_pushstring(L, "");
    }

    fclose(fptr);

    lua_setfield(L, -2, "query_highlights");

    lua_setfield(L, -2, "json");
}

static const struct luaL_Reg libtreesitter[] = {
    {"with_parser_do", l_with_parser_do},
    {"parser_set_language", l_parser_set_language},
    {"with_tree_do", l_with_tree_do},
    {"with_tree_root_node_do", l_with_tree_root_node_do},
    {"node_string", l_node_string},
    {"ast", l_ast},
    {"tree_language", l_tree_language},
    {"language_symbols", l_language_symbols},
    {"with_query_do", l_with_query_do},
    {"with_query_cursor_do", l_with_query_cursor_do},
    {"query_matches", l_query_matches},

    {NULL, NULL} /* sentinel */
};

void languages_table(lua_State *L)
{
    lua_newtable(L);

    add_language_json(L);

    lua_setfield(L, -2, "languages");
}

void query_errors_enum(lua_State *L)
{
    lua_newtable(L);

    lua_pushinteger(L, TSQueryErrorNone);
    lua_setfield(L, -2, "none");

    lua_pushinteger(L, TSQueryErrorSyntax);
    lua_setfield(L, -2, "syntax");

    lua_pushinteger(L, TSQueryErrorNodeType);
    lua_setfield(L, -2, "node_type");

    lua_pushinteger(L, TSQueryErrorField);
    lua_setfield(L, -2, "field");

    lua_pushinteger(L, TSQueryErrorCapture);
    lua_setfield(L, -2, "capture");

    lua_pushinteger(L, TSQueryErrorStructure);
    lua_setfield(L, -2, "structure");

    lua_pushinteger(L, TSQueryErrorLanguage);
    lua_setfield(L, -2, "language");

    lua_setfield(L, -2, "query_errors");
}

int luaopen_libtreesitter(lua_State *L)
{
    luaL_newlib(L, libtreesitter);

    languages_table(L);

    query_errors_enum(L);

    return 1;
}
