
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


local msg2=protobuf.decode("Person",bin)

print("decode:")

--printTable(msg2)

print(msg2.name)

print(msg2.phone[1].number)

bin=protobuf.encode("Person",{name="1"})

msg2=protobuf.decode("Person",bin)




--print(#msg2.phone)

--[[
local bit= require("bit")
print(msg2._bitField)
print(bit.band(msg2._bitField , 0x1) == 0x1)
print(bit.band(msg2._bitField , 0x2) == 0x2)
print(bit.band(msg2._bitField , 0x4) == 0x4)
print(bit.band(msg2._bitField , 0x8) == 0x8)
print(bit.band(msg2._bitField , 0x10) == 0x10)
--]]
local t2 = os.clock()

--print(t2-t1)
