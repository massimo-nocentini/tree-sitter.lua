
linux:
	cc -O3 -fPIC -Wall -shared -o libtreesitter.so libtreesitter.c \
		../tree-sitter-json/src/parser.c \
		../tree-sitter-c/src/parser.c \
		../tree-sitter-sql/src/parser.c ../tree-sitter-sql/src/scanner.cc \
		../tree-sitter-lua/src/parser.c ../tree-sitter-lua/src/scanner.c \
		-llua -ltree-sitter -lstdc++

install:
	mkdir -p /usr/local/lib/lua/5.4/	# just for ensuring that the dest dir exists
	mkdir -p /usr/local/share/lua/5.4/	# just for ensuring that the dest dir exists
	mkdir -p /usr/local/share/lua/5.4/tree-sitter/
	cp tree-sitter.lua /usr/local/share/lua/5.4/
	cp ../tree-sitter-json/queries/highlights.scm /usr/local/share/lua/5.4/tree-sitter/highlights-json.scm
	cp ../tree-sitter-c/queries/highlights.scm /usr/local/share/lua/5.4/tree-sitter/highlights-c.scm
	cp ../tree-sitter-sql/queries/highlights.scm /usr/local/share/lua/5.4/tree-sitter/highlights-psql.scm
	cp ../tree-sitter-lua/queries/highlights.scm /usr/local/share/lua/5.4/tree-sitter/highlights-lua.scm

install-linux: install
	mv libtreesitter.so /usr/local/lib/lua/5.4/

install-macos: install
	mv libtreesitter.dylib /usr/local/lib/lua/5.4/
	
test:
	cd ../test && lua test-libc.lua -v > README
