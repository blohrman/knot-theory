from util import arr_to_str
import numpy as np

'''
Simple method to convert from a Dowker–Thistlethwaite Code to a Gauss Code.

Input: String representation of the DT Code, e.g. "4 6 2" (trefoil)
Output: String representation of the corresponnding Gauss Code, e. g. "1 2 3 1 2 3" (trefoil)
'''
def dt_to_gauss(dt_code):
    
    # convert string to an array (much easier to work with in loops)
    codeArr = dt_code.split()
    num_crossings = len(codeArr)
    
    # pair each element with its corresponding odd number
    num = 1
    pairs = []
    for elem in codeArr:
        pairs.append([num, int(elem)])
        num += 2
    
    # create our output array of the corresponding crossings and initialize our initial crossing
    corr_crossing = np.zeros(num_crossings * 2)
    crossing = 1
    
    # loop over the length of the gauss code
    for i in range(num_crossings * 2):
        
        # loop over all of the pairs of numbers
        for j in range(len(pairs)):
            
            # check and see if the pair contains the corresponding index, and if so place the crossing number
            # in the corresponding location of the gauss code an break out of the loop
            if (pairs[j][0] == (i + 1) or pairs[j][1] == (i + 1)):
                corr_crossing[pairs[j][0] - 1] = crossing
                corr_crossing[pairs[j][1] - 1] = crossing
                del(pairs[j])
                
                crossing += 1
                break
    
    return arr_to_str(corr_crossing)

'''
Simple method to convert from a Gauss Code to a Dowker–Thistlethwaite Code.

Input: String representation of the Gauss Code, e.g. "1 2 3 1 2 3" (trefoil)
Output: String representation of the corresponnding DT Code, e. g. "4 6 2" (trefoil)
'''
def gauss_to_dt(gauss_code):
    
    # convert string to an array and make the elements integers (much easier to work with in loops)
    codeArr = gauss_code.split()
    codeArr = [int(num) for num in codeArr]
    
    # loop over the length of the outgoing dt code
    crossing = 1
    pairs = []
    for i in range(len(codeArr) // 2):
        pair = []
        
        # loop over the length of the gauss code and append the index of the crossing to a pair
        for j in range(len(codeArr)):
            if (codeArr[j] == crossing):
                pair.append(j + 1)

        pairs.append(pair)
        crossing += 1
    
    # loop over the odd numbers in the length of the gauss code
    out = []
    for i in range(1, len(codeArr), 2):
        
        # check each pair and add the even number output corresponding to the correct odd number to the output
        for pair in pairs:
            if (pair[0] == i or pair[1] == i):
                out.append(pair[0] if pair[0] % 2 == 0 else pair[1])
                
    return arr_to_str(out)