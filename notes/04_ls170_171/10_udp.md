# User Datagram Protocol (UDP)
UDP is another popular protocol on the transport layer. The Protocol Data Unit
(PDU) of UDP is known as a Datagram. Similar to TCP, it uses the Source and
Destination Port numbers to provide multiplexing. 

![UDP Header](images/31_udp_header.png)

Unlike TCP, UDP does not provide reliable communication.
- It does not guarantee message delivery
- It does not guarantee message delivery order
- It has no built-in congestion avoidance (i.e. network) or flow-control 
(recipient) mechanisms
- It is a connectionless protocol, and hence has no connection state tracking

## The Case for UDP
UDP provides **speed and flexibility** to its applications.
- Being a connectionless protocol, applications using it can start sending 
data without incurring the latency involved in establishing a connection
- Without acknowledgements and retransmissions, data delivery is faster and
it also remove the issue of [Head-of-line blocking](09_tcp.md#disadvantages-of-tcp).
- Application developers choosing UDP has flexibility to choose only the 
type or level of reliability required rather than take it wholesale if they 
use TCP e.g. implement sequencing but not retransmission.
- Some applications such as video calling or online gaming requires speed for
good user experience. Occasional loss of data causing a slight glitch is
better than significant lag.
