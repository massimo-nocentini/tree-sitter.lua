
local libc = require 'libc'
local lu = require 'luaunit'
local lambda = require 'operator'
local treesitter = require 'tree-sitter'

local json = [[

{
    "page": 1,
    "size": 10,
    "numberOfItems": 10,
    "numberOfPages": 1,
    "items": [
        {
            "_id": "644b96d55430b29449b6c443",
            "created": "2023-04-28T09:28:41+02:00",
            "replicationkey": 1000000873710,
            "locationoutgoing": 1,
            "locationincoming": 0,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/b94477aa-d757-4e47-98e4-abccfd9d5564",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 0,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b29449b6c443/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b29449b6c443",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b29449b6c443",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b29449b6c443",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b29449b6c443/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96d55430b2b534b6c445",
            "created": "2023-04-28T09:28:41+02:00",
            "replicationkey": 1000000873710,
            "locationoutgoing": 1,
            "locationincoming": 2,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/b94477aa-d757-4e47-98e4-abccfd9d5564",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 0,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b2b534b6c445/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b2b534b6c445",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b2b534b6c445",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b2b534b6c445",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d55430b2b534b6c445/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96d65430b290f5b6c447",
            "created": "2023-04-28T09:28:41+02:00",
            "replicationkey": 1000000873710,
            "locationoutgoing": 1,
            "locationincoming": 3,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/b94477aa-d757-4e47-98e4-abccfd9d5564",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 0,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d65430b290f5b6c447/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d65430b290f5b6c447",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d65430b290f5b6c447",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d65430b290f5b6c447",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d65430b290f5b6c447/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96d75430b2dddfb6c449",
            "created": "2023-04-28T09:28:41+02:00",
            "replicationkey": 1000000873710,
            "locationoutgoing": 1,
            "locationincoming": 4,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/b94477aa-d757-4e47-98e4-abccfd9d5564",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 0,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2dddfb6c449/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2dddfb6c449",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2dddfb6c449",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2dddfb6c449",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2dddfb6c449/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96d75430b2a8bcb6c44b",
            "created": "2023-04-28T09:28:41+02:00",
            "replicationkey": 1000000873710,
            "locationoutgoing": 1,
            "locationincoming": 5,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/b94477aa-d757-4e47-98e4-abccfd9d5564",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 0,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2a8bcb6c44b/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2a8bcb6c44b",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2a8bcb6c44b",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2a8bcb6c44b",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96d75430b2a8bcb6c44b/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96e05430b2ac27b6c457",
            "created": "2023-04-28T09:28:57+02:00",
            "replicationkey": 1000000873711,
            "locationoutgoing": 1,
            "locationincoming": 0,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/124d8553-86f5-41e6-8182-72df2588827f",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 1,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b2ac27b6c457/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b2ac27b6c457",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b2ac27b6c457",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b2ac27b6c457",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b2ac27b6c457/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96e05430b25df6b6c459",
            "created": "2023-04-28T09:28:57+02:00",
            "replicationkey": 1000000873711,
            "locationoutgoing": 1,
            "locationincoming": 2,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/124d8553-86f5-41e6-8182-72df2588827f",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 1,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b25df6b6c459/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b25df6b6c459",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b25df6b6c459",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b25df6b6c459",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e05430b25df6b6c459/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96e15430b2286ab6c45b",
            "created": "2023-04-28T09:28:57+02:00",
            "replicationkey": 1000000873711,
            "locationoutgoing": 1,
            "locationincoming": 3,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/124d8553-86f5-41e6-8182-72df2588827f",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 1,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b2286ab6c45b/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b2286ab6c45b",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b2286ab6c45b",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b2286ab6c45b",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b2286ab6c45b/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96e15430b24105b6c45d",
            "created": "2023-04-28T09:28:57+02:00",
            "replicationkey": 1000000873711,
            "locationoutgoing": 1,
            "locationincoming": 4,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/124d8553-86f5-41e6-8182-72df2588827f",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 1,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b24105b6c45d/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b24105b6c45d",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b24105b6c45d",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b24105b6c45d",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e15430b24105b6c45d/EditLink",
                    "method": "post"
                }
            }
        },
        {
            "_id": "644b96e25430b2e4f0b6c45f",
            "created": "2023-04-28T09:28:57+02:00",
            "replicationkey": 1000000873711,
            "locationoutgoing": 1,
            "locationincoming": 5,
            "commandurl": [
                {
                    "smallThumbnail": null,
                    "url": "https://apptiveattachmentsalpha-apptiveattachmentbucket-rg72rfbppffp.s3.eu-central-1.amazonaws.com/124d8553-86f5-41e6-8182-72df2588827f",
                    "largeThumbnail": null,
                    "name": null,
                    "type": "string"
                }
            ],
            "attachmentcount": 1,
            "status": "new",
            "errortext": null,
            "_links": {
                "partialUpdate": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e25430b2e4f0b6c45f/update",
                    "method": "post"
                },
                "self": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e25430b2e4f0b6c45f",
                    "method": "get"
                },
                "update": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e25430b2e4f0b6c45f",
                    "method": "put"
                },
                "remove": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e25430b2e4f0b6c45f",
                    "method": "delete"
                },
                "addEditionLink": {
                    "href": "/api/users/6315f0a9f5ca3bb794a42cb3/spaces/6315f0b667d3ac2664a44f52/grids/631ee7590cb7e1473fa4c5ee/entities/644b96e25430b2e4f0b6c45f/EditLink",
                    "method": "post"
                }
            }
        }
    ]
}

]]

print ('lines #', #json:lines (true))

local function P (tbl)

    for k, v in pairs (tbl) do 
        if type (v) == 'table' then print (k); P (v)
        else print (k, v) end
    end

    print '------------------'
end

local flag, one = treesitter.with_parser_do (
    function (parser)
        local set = treesitter.parser_set_language (parser, 'json')
        assert (set, 'Cannot set the json language')

        local f, o = treesitter.with_tree_do (
            parser,
            json,
            function (tree)
                local tree_root = treesitter.tree_root_node (tree)
                return treesitter.node_string (tree_root)
            end
        )
        assert (f)

        return o
    end
)
assert (flag)

print ( one)


json = [[

    { "hello": [ 42, 1.618, "world" ]}

]]

local flag, ast = treesitter.with_parser_do (
    function (parser)
        local set = treesitter.parser_set_language (parser, 'json')
        assert (set, 'Cannot set the json language')

        local f, ast = treesitter.with_tree_do (
            parser,
            json,
            function (tree) return treesitter.ast (tree, json) end
        )
        assert (f)

        return ast
    end
)
assert (flag)

treesitter.walk (ast, function (node_type, field_name, is_named, s, e)
    --print (json:sub (s, e))
end)

local flag, symbols = treesitter.with_parser_do (
    function (parser)
        local set = treesitter.parser_set_language (parser, 'json')
        assert (set, 'Cannot set the json language')

        local f, symbols = treesitter.with_tree_do (
            parser,
            json,
            function (tree)
                local lang = treesitter.tree_language (tree)
                return treesitter.language_symbols (lang)
            end
        )
        assert (f)

        return symbols
    end
)
assert (flag)


Test_constants = {}

function Test_constants:test_gr ()
	
	lu.assertEquals(ast, 1)
end


function Test_constants:test_symbols ()
	
	--lu.assertEquals(symbols, 1)
end

print 'IN ONE SHOT'

treesitter ('json', json, function (node_type, field_name, is_named, s, e)
    print (node_type, field_name, json:sub (s, e))
end)

--------------------------------------------------------------------------------

os.exit( lu.LuaUnit.run() )