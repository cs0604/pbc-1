
function printTable(tb,ti)
	ti = ti or 0
	for k=1,ti do
	 io.write(" ")
	end
	for i,v in pairs(tb) do
		if type(v)=="table" then
			print(i," table")
			printTable(v,ti+1)
		else
			print(i," ",v)
		end
	end
end


local t1=os.clock()

local protobuf = require "xuyun.protobuf"

--print(type(protobuf))
--[[
addr = io.open("person2.pb","rb")
buffer = addr:read "*a"
addr:close()
protobuf.register(buffer)
--]]

protobuf.register_file("person2.pb")


local person = {
	name =  "John Doe",
	id = 1234,
	email =  "jdoe@example.com",
	--testop = 0,
	phone = {
	{type="MOBILE",number="123"}
	}
}

--person.phone._bitField = 5 
--[[
for i =1,550000 do
	
	local phone_work={
		type = "MOBILE",
		number = "123-456-7890"
	}
	
	table.insert(person.phone,phone_work)
end
--]]


local bin=protobuf.encode("Person",person)

print("encode len:",#bin)

local file=io.open("encode.bin","wb")
file:write(bin)
file:close()



local t2 = os.clock()

--print(t2-t1)
