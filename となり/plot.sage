#!/bin/env sage

import sys
from sage.all import *

def readData():
    res=""
    for ln in sys.stdin:
        res+=ln
    res=sage_eval(res)
    # res=[vector(x) for x in res]
    return res

def main():
    Gph=line(readData())
    Gph.save("./plot.png", aspect_ratio=1, dpi=300)

main()
