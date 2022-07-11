!/bin/python
#by Tristan with help from TCM

import sys
import socket
from datetime import datetime 

#Define the target
if len(sys.argv) == 2:
	target = socket.gethostbyname(sys.argv[1])  #Translate hostname to IPv4

else:
	print("Invalid Amout Of Arguments.")
	print("Syntax: python3 py-portscanner.py <IP>")

#Add A Banner
print("_" * 50)
print("Scanning target " + target)
print("Time Started: " + str(datetime.now() ) )
print("_" * 50)
	
try:
	for port in range(1,1000):
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		socket.setdefaulttimeout(1)
		result = s.connect_ex((target,port)) #If open = 0, error = 1 
		if result == 0:
			print("Port {} is open".format(port))
		s.close()
		
except KeyboardInterrupt:
	print("\nExiting Program")
	sys.exit()
	
except socket.gaierror:
	print("Hostname Could Not Be Resolved")	
	sys.exit()
	
except socket.error:
	print("Could Not Connect To Server")
	sys.exit()	
	
