-- Created by laqieer/MisakaMikoto@FEU
-- 2016/08/06
-- Input: map.lua
-- Output: terrain.conf.bin map.bin
-- 输入的地图是空白的，但是有编辑好地形信息和地图的宽高信息
require "bit"
map = dofile("blankmap.lua")
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
local out = io.open("blankmap.bin","wb")
out:write(string.char(map["layers"][1]["width"]))
out:write(string.char(map["layers"][1]["height"]))
for i=0,map["layers"][1]["height"]-1 do
	for j=0,map["layers"][1]["width"]-1 do
		tileid = 32*i+j
		tileoffset = 4*tileid
		out:write(string.char(bit.band(tileoffset,0xFF),bit.band(bit.rshift(tileoffset,8),0xFF)))
	end
end
out:close();