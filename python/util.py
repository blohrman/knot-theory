def arr_to_str(arr):
    out = ""
    for elem in arr:
        out += str(int(elem)) + " "
        
    return out.strip()