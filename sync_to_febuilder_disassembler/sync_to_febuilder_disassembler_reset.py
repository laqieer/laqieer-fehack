#coding=utf-8

'''
重新配置sync_to_febuilder_disassembler插件.
Run this script to reset and reconfigure sync_to_febuilder_disassembler plugin.
by laqieer
2018/02/25
'''

import idaapi

idaapi.netnode("$ gba_fe_info", 0, True).kill()
Warning("Reset the plugin successfully.\nPlease save, close and reopen the IDA database to reconfigure.")