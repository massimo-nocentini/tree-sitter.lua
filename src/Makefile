
linux:
	cc -O3 -std=gnu11 -fPIC -Wall -shared -o libtreesitter.so libtreesitter.c -llua -ltree-sitter /usr/local/lib/libtree-sitter-json.a

macos:

install:
	mkdir -p /usr/local/lib/lua/5.4/	# just for ensuring that the dest dir exists
	mkdir -p /usr/local/share/lua/5.4/	# just for ensuring that the dest dir exists
	mv libtreesitter.so /usr/local/lib/lua/5.4/
	cp tree-sitter.lua /usr/local/share/lua/5.4/

install-macos:
	mkdir -p /usr/local/lib/lua/5.4/	# just for ensuring that the dest dir exists
	mkdir -p /usr/local/share/lua/5.4/	# just for ensuring that the dest dir exists
	mv libtreesitter.dylib /usr/local/lib/lua/5.4/
	cp tree-sitter.lua /usr/local/share/lua/5.4/
test:
	cd ../test && lua test-libc.lua -v > README
