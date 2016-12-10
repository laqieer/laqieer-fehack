.thumb
push {r6-r7}
mov r1,#0x30
lsl r1,r1,#8	@r1=0x3000
and r1,r0,r1	@取翻转flag
push {r1}
mov r1,#0x10
lsl r1,r1,#8
sub r1,r1,#1	@r1=0xFFF
and r1,r0,r1	@r0=地图数据里16x16的一个Tile的代号
lsl r1,r1,#1
ldr r0,=#0x2030A8C
add r2,r1,r0
ldr r0,=#0x202E3E8
ldr r0,[r0]
add r4,r4,r0
ldr r0,[r4]
add r0,r0,r3
ldrb r0,[r0]
mov r3,#0xB0
lsl r3,r3,#8
cmp r0,#0
beq lab_8019802
mov r3,#0xC0
lsl r3,r3,#7
lab_8019802:
pop {r6}
cmp r6,#0
bne lab_flipping
ldrh r1,[r2]
add r0,r1,r3
strh r0,[r5]
add r2,#2
ldrh r4,[r2]
add r0,r4,r3
strh r0,[r5,#2]
add r2,#2
mov r1,r5
add r1,#0x40
ldrh r4,[r2]
add r0,r4,r3
strh r0,[r1]
add r1,#2
ldrh r2,[r2,#2]
add r0,r2,r3
strh r0,[r1]
b end
lab_flipping:
mov r7,#2
lsl r7,r7,#12	@r7=0x2000
cmp r6,r7
bne lab_nonVerticalFlipping
mov r7,#8
lsl r7,r7,#8	@r7=0x400
ldrh r1,[r2]
add r0,r1,r3
add r5,#0x40
eor r0,r0,r7
strh r0,[r5]
add r2,#2
ldrh r4,[r2]
add r0,r4,r3
eor r0,r0,r7
strh r0,[r5,#2]
add r2,#2
mov r1,r5
sub r1,#0x40
ldrh r4,[r2]
add r0,r4,r3
eor r0,r0,r7
strh r0,[r1]
add r1,#2
ldrh r2,[r2,#2]
add r0,r2,r3
eor r0,r0,r7
strh r0,[r1]
b end
lab_nonVerticalFlipping:
mov r7,#1
lsl r7,r7,#12	@r7=0x1000
cmp r6,r7
bne lab_nonHorizontalFlipping
mov r7,#4
lsl r7,r7,#8	@r7=0x800
ldrh r1,[r2]
add r0,r1,r3
eor r0,r0,r7
strh r0,[r5,#2]
add r2,#2
ldrh r4,[r2]
add r0,r4,r3
eor r0,r0,r7
strh r0,[r5]
add r2,#2
mov r1,r5
add r1,#0x40
ldrh r4,[r2]
add r0,r4,r3
add r1,#2
eor r0,r0,r7
strh r0,[r1]
sub r1,#2
ldrh r2,[r2,#2]
add r0,r2,r3
eor r0,r0,r7
strh r0,[r1]
b end
lab_nonHorizontalFlipping:
mov r7,#0xC
lsl r7,r7,#8	@r7=0xC00
ldrh r1,[r2]
add r0,r1,r3
eor r0,r0,r7
add r5,#0x40
strh r0,[r5,#2]
add r2,#2
ldrh r4,[r2]
add r0,r4,r3
eor r0,r0,r7
strh r0,[r5]
add r2,#2
mov r1,r5
sub r1,#0x40
ldrh r4,[r2]
add r0,r4,r3
add r1,#2
eor r0,r0,r7
strh r0,[r1]
sub r1,#2
ldrh r2,[r2,#2]
add r0,r2,r3
eor r0,r0,r7
strh r0,[r1]
end:
pop {r6,r7}
pop {r4,r5}
pop {r0}
bx r0
