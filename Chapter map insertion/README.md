Insert chapter maps, map changes and map tileset.

插入地图、地图变换和地图图层。

laqieer

Commands to generate maps, map changes and map tileset data:

grit 0.png -gB4 -mLf -gT000000 -m -mB16:p4vhi10 -mp0 -mR4 -mRtf -pn16 -ftb
grit 1.png -gB4 -mLf -gT000000 -m -mB16:p4vhi10 -mp1 -mR4 -mRtf -pn16 -ftb -ma129
grit 2.png -gB4 -mLf -gT000000 -m -mB16:p4vhi10 -mp2 -mR4 -mRtf -pn16 -ftb -ma350
grit 3.png -gB4 -mLf -gT000000 -m -mB16:p4vhi10 -mp3 -mR4 -mRtf -pn16 -ftb -ma446
grit 4.png -gB4 -mLf -gT000000 -m -mB16:p4vhi10 -mp4 -mR4 -mRtf -pn16 -ftb -ma662
copy /b 0.pal.bin+1.pal.bin+2.pal.bin+3.pal.bin+4.pal.bin tileset.pal.dmp
copy /b 0.img.bin+1.img.bin+2.img.bin+3.img.bin+4.img.bin tileset.img.dmp
copy /b 0.map.bin+1.map.bin+2.map.bin+3.map.bin+4.map.bin tileset.map.bin
RearrangeTilemap
lua mapConveter.lua
copy /b tile.conf.bin+terrain.conf.bin tileset.conf.dmp