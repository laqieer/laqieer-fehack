//A demo OP
//laqieer	2016-12-11
#include <stdio.h>
#include <tonc.h>

__attribute__((section(".0x09003000")))
void hello()
{
	REG_DISPCNT= DCNT_MODE0 | DCNT_BG0;

	tte_init_se_default(0, BG_CBB(0)|BG_SBB(31));
	tte_write("Hello World!\n");
	
	while(!KEY_DOWN_NOW(KEY_START));
	
	tte_write("Long times ago\n");
	
	while(!KEY_DOWN_NOW(KEY_SELECT));
	
	tte_write("Blablabla...\n");
	
	while(!KEY_DOWN_NOW(KEY_START));
	
	tte_write("-- laqieer\n");
	
	while(!KEY_DOWN_NOW(KEY_SELECT));
	
	REG_DISPCNT= 0x403;
	CpuFastSet((void *)0x9004000,(void *)0x6000000,0x960 * 8);
	
	while(!KEY_DOWN_NOW(KEY_START));
	
//	asm volatile("mov %r0, #0x12");
	
	asm __volatile__ (".long 0xE3A00012");
	
	return;
}