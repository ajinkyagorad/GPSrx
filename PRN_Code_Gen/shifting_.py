#referenced https://natronics.github.io/blag/2014/gps-prn/
# Make a shift register, length 10 with all ones
G1 =[1 for i in xrange(10)]
print G1
# take feedback from couple of positions 
fb3 = G1[3-1] # position  3
fb10 = G1[10-1] # positoin 10
fb = (fb3+fb10)%2 # modulo 2 add
print fb

# Now we have the number to push in first position, shift the register 'clock it'
for i in reversed(range(len(G1[1:]))):
	G1[i+1] = G1[i]
G1[0] = fb
print G1	



fb = (G1[3-1] + G1[10-1]) % 2
for i in reversed(range(len(G1[1:]))):
    G1[i+1] = G1[i]
G1[0] = fb
print G1

