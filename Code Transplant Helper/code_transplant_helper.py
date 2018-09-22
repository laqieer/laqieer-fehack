# Help to transplant code between diffrent versions of GBAFE
# by laqieer
# 2018-09-22

from idaapi import *
from treelib import Node, Tree
from enum import Enum

class XType(Enum):
    data = 0
    code = 1
    proc = 2

class Xref_node:
    'xref info stored in the node'
    xrefCount = 0

    def __init__(self, name, addr, xType, mirror):
        self.name = name
        self.addr = addr
        self.xType = xType
        self.mirror = mirror
        Xref_node.xrefCount += 1

def get_mirror(ea):
    'find the mirror in the other rom'
    #TODO: just a place holder now
    
    return 0

def add_xrefs(ea):
    'add nodes recursively'
    func = get_func(ea)
    if not func is None:
        ea = func.startEA
        items = FuncItems(ea)
        for i in items:
            for xref in XrefsFrom(i, 0):
                if not tree.contains(xref.to):
                    if xref.type != fl_JN and xref.type != fl_JF and xref.type != fl_F and xref.type != dr_O:
                        name = Name(xref.to)
                        if xref.type == fl_CN or xref.type == fl_CF:
                            xType = XType.code
                        else:
                            if xref.type == dr_R or xref.type == dr_W:
                                #TODO: Recoginze PROC
                                
                                xType = XType.data
                                
                        mirror = get_mirror(xref.to)
                        tree.create_node(name, xref.to, parent=ea, data=Xref_node(name, xref.to, xType, mirror))
                        if mirror == 0 and xType != XType.data:
                            add_xrefs(xref.to)
    #else:
        #TODO: Handle PROC
        
    return

root = get_func(here())
if not root is None:
    tree = Tree()
    fname = Name(root.startEA)
    mirror = get_mirror(root.startEA)
    tree.create_node(fname, root.startEA, data=Xref_node(fname, root.startEA, XType.code, mirror))
    if mirror == 0:
        add_xrefs(root.startEA)
    Message("%d references in function %s need transplanting:\n" % (Xref_node.xrefCount - 1, fname))
    tree.show(line_type="ascii-em")
else:
    Warning("No function found at location %x" % here())
