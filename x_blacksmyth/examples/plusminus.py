

def oracle(a : int, b : int):
    ret = 0
    if a == 0:
        ret = b+1
    else:
        ret = b-1
    return abs(ret)