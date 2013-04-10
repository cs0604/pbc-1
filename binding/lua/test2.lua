package.path = package.path .. ";/search/xuyun/lua/pbc/binding/lua/?.lua;"
package.cpath = package.cpath .. ";/usr/local/nginx/lua/clib/?.so;"

local cjson = require("cjson")

local protobuf = require "xuyun.protobuf"

addr = io.open("../../build/addressbook.pb","rb")
buffer = addr:read "*a"
addr:close()
protobuf.register(buffer)

local person = {
	name = "Alice",
	id = 123,
	phone = {
		{ number = "123456789" , type = "MOBILE" },
		{ number = "87654321" , type = "HOME" },
	}
}

local buffer = protobuf.encode("tutorial.Person", person)

print(string.len(buffer))

local t = protobuf.decode("tutorial.Person", buffer)


print(cjson.encode(t))
