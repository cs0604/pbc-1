.PHONY : all 51 clean

all :
	gcc -O2   --shared -o protobuf.so -L../../build/ -I../../  pbc-lua.c -lpbc  -fPIC

51 :
#	gcc -O2 -Wall --shared -o protobuf.dll -I../.. -I/d/project/luajit-2.0/src -L/usr/local/bin -L../../build pbc-lua.c -lpbc -llua51
	gcc -O2 -Wall -fPIC -o protobuf.so  -I../.. -I/d/project/lua-5.1.4/src -L/usr/local/bin -L../../build pbc-lua.c -lpbc -lluajit-5.1

clean :
	rm protobuf.dll
