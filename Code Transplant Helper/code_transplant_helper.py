# Help to transplant code between diffrent versions of GBAFE
# by laqieer
# 2018-09-22

from idaapi import *
from treelib import Node, Tree
from enum import Enum
import sqlite3

class XType(Enum):
    data = 0
    code = 1
    proc = 2

class Xref_node:
    'xref info stored in the node'
    #xrefCount = 0
    xrefTrans = 0

    def __init__(self, name, addr, xType, mirror):
        self.name = name
        self.addr = addr
        self.xType = xType
        self.mirror = mirror
        #Xref_node.xrefCount += 1
        if type(mirror) is str and xType != XType.data:
            Xref_node.xrefTrans += 1

def get_mirror(ea):
    'find the mirror in the other rom'
    #TODO: just a place holder now
    if conn is not None and c is not None:
        cursor = c.execute("select address2, name2, ratio from results where address = '%08x'" % ea)
        for row in cursor:
            if float(row[2]) > 0.8:
                return (Name(ea), hex(int(row[0], 16)), row[1])
    return Name(ea)

def add_xrefs(ea, type):
    'add nodes recursively'
    if type == XType.code:
        func = get_func(ea)
        ea = func.startEA
        items = FuncItems(ea)
        for i in items:
            for xref in XrefsFrom(i, 0):
                if not tree.contains(hex(xref.to)):
                    if xref.type != fl_JN and xref.type != fl_JF and xref.type != fl_F and xref.type != dr_O:
                        name = Name(xref.to)
                        if xref.type == fl_CN or xref.type == fl_CF:
                            xType = XType.code
                        else:
                            if xref.type == dr_R or xref.type == dr_W:
                                #TODO: Recoginze PROC
                                
                                xType = XType.data
                                
                        mirror = get_mirror(xref.to)
                        tree.create_node(name, hex(xref.to), parent=hex(ea), data=Xref_node(name, hex(xref.to), xType, mirror))
                        #if mirror == 0 and xType != XType.data:
                        if mirror == Name(xref.to):
                            add_xrefs(xref.to, xType)
    else:
        #TODO: Handle PROC
        
        for xref in DataRefsFrom(ea):
            if not tree.contains(hex(xref)):
                name = Name(xref)
                xType = XType.data
                mirror = get_mirror(xref)
                tree.create_node(name, hex(xref), parent=hex(ea), data=Xref_node(name, hex(xref), xType, mirror))
    return

root = get_func(here())
if not root is None:
    tree = Tree()
    fname = Name(root.startEA)
    # read mirror info from diaphora database
    filename = AskFile(0, "*.diaphora", "Select the database to load mirror infomation")
    if filename is not None:
        conn = sqlite3.connect(filename)
        c = conn.cursor()
    mirror = get_mirror(root.startEA)
    tree.create_node(fname, hex(root.startEA), data=Xref_node(fname, hex(root.startEA), XType.code, mirror))
    if mirror == fname:
        add_xrefs(root.startEA, XType.code)
    tree.show(line_type="ascii-em", idhidden=False, data_property='mirror')
    Message("%d subroutines in routine %s need transplanting.\n" % (Xref_node.xrefTrans - 1, fname))
    conn.close()
else:
    Warning("No function found at location %x" % here())
