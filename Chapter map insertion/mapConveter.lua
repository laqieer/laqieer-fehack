-- Created by laqieer/MisakaMikoto@FEU
-- 2016/07/31
-- Input: map.lua
-- Output: terrain.conf.bin map.dmp mapChange.conf.dmp mapChange(X)(offset).dmp
-- 生成图层的地形配置；生成地图数据(添加了对图块翻折变换的支持)；生成地图变换数据
require "bit"
map = dofile("map.lua")
local out = io.open("terrain.conf.bin","wb")
terrain = {}
for i=0,1023 do
	terrain[i] = 0
end
if(next(map["tilesets"][1]["tiles"]) ~= nil)
then
	for k,v in pairs(map["tilesets"][1]["tiles"]) do
		terrain[v["id"]] = map["tilesets"][1]["terrains"][v["terrain"][1]+1]["properties"]["ID"]
	end
end
for i=0,1023 do
	out:write(string.char(terrain[i]))
end
out:close();
local header = io.open("mapChange.conf.dmp","ab")
for k,v in pairs(map["layers"]) do
	if(v["name"] == "Main")
	then
		local out = io.open("map.dmp","wb")
		out:write(string.char(v["width"]))
		out:write(string.char(v["height"]))
		for key,value in ipairs(v["data"]) do
--			flipflag = bit.rshift(value,26)
			flipflag = bit.rshift(bit.band(value,0xC0000000),26)
			if(flipflag == 0x10)
			then
				flipflag = 0x20
			end
			if(flipflag == 0x20)
			then
				flipflag = 0x10
			end
			metatile = bit.band(value-1,1023)*4
			out:write(string.char(bit.band(metatile,0xFF),bit.bor(bit.band(bit.rshift(metatile,8),0xFF),flipflag)))
--			out:write(string.char(bit.band(metatile,0xFF),bit.band(bit.rshift(metatile,8),0xFF)))
		end
		out:close();
	else
		local out = io.open("mapChange("..tostring(v["properties"]["ID"])..")("..v["properties"]["Offset"]..").dmp","wb")
		for key,value in ipairs(v["data"]) do
			if(value ~= 0)
			then
--				flipflag = bit.rshift(value,26)
				flipflag = bit.rshift(bit.band(value,0xC0000000),26)
				if(flipflag == 0x10)
				then
					flipflag = 0x20
				end
				if(flipflag == 0x20)
				then
					flipflag = 0x10
				end
				metatile = bit.band(value-1,1023)*4
				out:write(string.char(bit.band(metatile,0xFF),bit.bor(bit.band(bit.rshift(metatile,8),0xFF),flipflag)))
--				out:write(string.char(bit.band(metatile,0xFF),bit.band(bit.rshift(metatile,8),0xFF)))
			end
		end
		out:close();
		header:write(string.char(v["properties"]["ID"],v["properties"]["X"],v["properties"]["Y"],v["properties"]["Width"],v["properties"]["Height"],0x00,0x00,0x00))
		header:write(string.char(bit.band(tonumber(string.sub(v["properties"]["Offset"],3),16),0xFF),bit.band(bit.rshift(tonumber(string.sub(v["properties"]["Offset"],3),16),8),0xFF),bit.band(bit.rshift(tonumber(string.sub(v["properties"]["Offset"],3),16),16),0xFF),bit.band(bit.rshift(tonumber(string.sub(v["properties"]["Offset"],3),16),24),0xFF)))
	end
end
header:write(string.char(0xFF,0x00,0x00,0x00))
header:close();