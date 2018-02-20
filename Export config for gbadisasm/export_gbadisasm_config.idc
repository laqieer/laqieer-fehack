// 从IDA数据库生成gbadisasm需要的配置文件. Export configuration file for gbadisasm from IDA database.
// by laqieer
// 2018/2/20

#include <idc.idc>

static main() {
	auto cfg, cfgName, addr, cmt, isARM, name;	
	cfgName = AskFile(1, "*.cfg", "export to");
	cfg = fopen(cfgName, "w");
	if(!cfg)
	{
		Warning("Error when opening %s", cfgName);
	}
	addr = 0;
	for(addr = NextFunction(addr); addr != BADADDR; addr = NextFunction(addr))
	{
		name = Name(addr);
		isARM = (FindCode(addr, SEARCH_DOWN | SEARCH_NEXT) - addr -2) / 2;
		cmt = GetFunctionCmt(addr, 1);
		fprintf(cfg, "# %s\n", cmt);	// 只允许单行注释，写入配置文件的多行注释从第二行开始开头会缺少#
		writestr(cfg, isARM? "arm_func": "thumb_func");
		fprintf(cfg, " 0x%x %s\n", addr, name);
	}
	fclose(cfg);
}