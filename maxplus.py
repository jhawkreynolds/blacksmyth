
#Oracle for max plus function
def oracle(a : int, b : int):
    res = a if a > b else b
    res += 1
    return res