from util import arr_to_str
import numpy as np

'''
Disclaimer: There is a chance this is done in a way too complicated fashion lol

Function to take a Gauss Code and "relabel" it such that the crossings begin with 1.
Used in the function to generate all possible Gauss Codes.

@author Ben Jammin'
'''
def relabel(arr):
    
    # create a map that maps the value to the indices at which it appears in the code
    indexMap = {}
    for i in range(len(arr)):
        if arr[i] not in indexMap.keys():
            indexMap[arr[i]] = [i]
        else:
            indexMap[arr[i]].append(i)
    
    # instantiate
    label = 1
    relabeled = np.zeros(len(arr))
    
    # loop over length of code
    for i in range(len(arr)):
        
        # loop over each item in the dictionary. if the current index is in the values, add the correct label
        # to the corresponding indices in the relabeled array
        toDelete = -1
        for key, val in indexMap.items():
            if i in val:
                toDelete = key
                
                # this is always of length 2 so it looks like bad time complexity but it's not as bad I promise
                for index in val:
                    relabeled[index] = label
        
        # if something was found for the corresponding index, remove from the map and increase the label
        if (toDelete != -1):
            del indexMap[toDelete]
            label += 1
        
    return relabeled

'''
Function to generate all possible Gauss Codes from a given Gauss Code.

Will return an array of strings representing the codes of length 2n, where n is the length of the Gauss Code.

@author Ben Jammin'
'''
def generate_gauss_codes(gauss_code):
    
    # code to array
    codeArr = gauss_code.split()
    codeArr = [int(num) for num in codeArr]
    
    codes = []
    codes.append(codeArr)
    
    # add each possible code via shifting to an array
    for i in range(len(codeArr) - 1):
        curr = codes[i].copy()
        curr.append(curr[0])
        del curr[0]
        codes.append(curr)
    
    # reverse each code created by shifting to get other possible codes
    reversals = []
    for i in range(len(codes)):
        curr = codes[i].copy()
        reversals.append(list(reversed(curr)))
        
    # concatenate the two to get them in one mega list
    codes = np.concatenate((codes, reversals))
    
    # relabel and make it pretty
    out = []
    for code in codes:
        code = relabel(code)
        out.append(arr_to_str(code))
    
    return out