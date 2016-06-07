#referenced https://natronics.github.io/blag/2014/gps-prn/


# let function do it
def shift(register, feedback, output):
    """GPS Shift Register
    
    :param list feedback: which positions to use as feedback (1 indexed)
    :param list output: which positions are output (1 indexed)
    :returns output of shift register:
    
    """
    
    # calculate output
    out = [register[i-1] for i in output]
    if len(out) > 1:
        out = sum(out) % 2
    else:
        out = out[0]
        
    # modulo 2 add feedback
    fb = sum([register[i-1] for i in feedback]) % 2
    
    # shift to the right
    for i in reversed(range(len(register[1:]))):
        register[i+1] = register[i]
        
    # put feedback in position 1
    register[0] = fb
    
    return out



# init registers
G1 = [1 for i in range(10)]
G2 = [1 for i in range(10)]

# work out first 10 bits
ca = []
for i in range(10):
    g1 = shift(G1, [3,10], [10]) #feedback 3,10, output 10
    g2 = shift(G2, [2,3,6,8,9,10], [2,6]) #feedback 2,3,6,8,9,10, output 2,6 for sat 1
    ca.append((g1 + g2) % 2)

print ca

