# This skeleton is valid for both Python 2.7 and Python 3.
# You should be aware of your additional code for compatibility of the Python version of your choice.

import time
from socket import *

# Get the server hostname and port as command line arguments                    
host = "localhost"  # FILL IN START		# FILL IN END
port = 12000  # FILL IN START		# FILL IN END
timeout = 1  # in seconds

# Create UDP client socket
# FILL IN START		
sock = socket(AF_INET, SOCK_DGRAM)

# Note the second parameter is NOT SOCK_STREAM
# but the corresponding to UDP

# Set socket timeout as 1 second
sock.settimeout(timeout)

# FILL IN END

# Sequence number of the ping message
ptime = 0

# Ping for 10 times
while ptime < 10:
    ptime += 1
    sendTime = time.time()
    # Format the message to be sent as in the Lab description	
    data = ("ping nr: " + str(ptime) + " " + str(time.time())).encode()  # FILL IN START		# FILL IN END
    sock.sendto(data, (host, port))

    try:
        message, server = sock.recvfrom(1024)
        timeRec = time.time()
        timeRTT = round(timeRec - sendTime, 4)
        print(str(message), "Ping nr:", str(ptime))
        print("RTT:", str(timeRTT))
    # Record the "sent time"

    # Send the UDP packet with the ping message

    # Receive the server response

    # Record the "received time"

    # Display the server response as an output

    # Round trip time is the difference between sent and received time

    # FILL IN END
    except:
        # Server does not response
        # Assume the packet is lost
        print("Request timed out.")
        continue

# Close the client socket
sock.close()
