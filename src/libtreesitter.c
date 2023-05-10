

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <time.h>
#include <math.h>
#include <tree_sitter/api.h>


static const struct luaL_Reg libtreesitter[] = {
    //{"write", l_write},
    
    {NULL, NULL} /* sentinel */
};

int luaopen_libtreesitter(lua_State *L)
{
    luaL_newlib(L, libtreesitter);
    return 1;
}
