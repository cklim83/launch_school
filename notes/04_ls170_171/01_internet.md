# The Internet
## Section Links

[What is the Internet?](#what-is-the-internet)\
[What happens when you enter a URL in a browser and press enter?](#what-happens-when-you-enter-a-url-in-a-browser-and-press-enter)\
[How does a message flow down the layers from the sender, across the network to the server and up the layers to the server application?](#how-does-a-message-flow-down-the-layers-from-the-sender-across-the-network-to-the-server-and-up-the-layers-to-the-server-application)\
[What is the web?](#what-is-the-web)\
[What is a resource?](#what-is-a-resource)\
[What is a Client-server model?](#what-is-a-client-server-model)\
[Server Components](#server-components)

---

## What is the Internet?
The internet is a "network of networks". A network is any plurality of
devices that are connected so that they can exchange data. Devices in
close proximity connected to hub/switch forms a local area network (LAN).
Lots of these LANs are then interconnected via routers to form the 
Internet. When we say "The Internet", we are describing both the physical
infrastructure that facilitates this interconnectivity, and the protocols
that govern its functionality.

Smallest Network\
![Simplest Network](./images/01_simplest_network_model.png)

Local Area Network\
![LAN](./images/02_lan_model.png)

Inter-Network\
![Inter-network](./images/03_inter_network_model.png)

Internet\
![Internet](./images/04_internet_model.png)

[Back to Top](#section-links)


## What happens when you enter a URL in a browser and press enter?

**URL -> IP Address with DNS**
- User enters `www.google.com` in the address bar of a browser.
- The browser asks the operating system to resolve the domain name to IP 
address with the Domain Name System (DNS) in the following order:
  - DNS cache on the local computer
  - DNS servers of the Internet Service Provider (ISP). 
  - ISP DNS servers will escalate the query to external DNS servers if it does not
  have the domain name's IP address.

  High Level DNS Workflow for Internet Traffic
  ![DNS Workflow](images/32_dns_diagram.png)

- It then sends a request to the server hosting the site to open a TCP connection. A three-way handshake ensues to open a TCP connection
- If the site is running on HTTPS, TLS handshake then ensues to setup a secure connection.
- The browser than sends a HTTP request to the server to request for that webpage. 
- The server processes the request and sends a response with a 3-digit code and text indicating the status of that request. It could be
  - 200 OK, indicating the request was successfully processed. The accompanying HTML file will be in the response body.
  - 3XX Found, indicating the resource has be relocated. A location header will indicate the new location of the resource.
  - 404 Not Found. The requested resources are not found. Client have provided an invalid url.
  - 500 Internal Server Error. Server has encountered an error. 
- The browser will process the response and render the result to the user.

**References**\
[What happens when you enter a URL in your browser](https://medium.com/@maneesha.wijesinghe1/what-happens-when-you-type-an-url-in-the-browser-and-press-enter-bb0aa2449c1a)

[Back to Top](#section-links)


## How does a message flow down the layers from the sender, across the network to the server and up the layers to the server application?
- Browser creates a HTTP request
- TLS encryptes the HTTP request and encapsulates the data into a Record (with a MAC field for integrity checks)
- TCP in the transport layer encapsulates the Record with a header that includes source and destination port number (extracted from URL) and sequence numbers amongst other fields to form a Segment
- IP encapsulates the TCP Segment with a header that includes the source and destination IP address (resolved from the DNS using the domain name in URL) to form a Packet. 
- Ethernet encapsulates the Packet in a **Frame** by adding header that includes source and destination MAC address.
  - Client computer does not have the MAC address of the server. Nonetheless, it recognise the destination IP address belongs to another network (different subnet mask) and know that it need to forward the Frame to its default gateway (local router). 
  - Although it knows the IP address of the local router, it does not have its MAC address in its own ARP table. To get it, it broadcast a ARP request asking for the MAC address of the device having the IP address of default gateway. The router responds to the request with its own MAC address. The host update its own ARP table with the MAC address of the router. It then construct a Frame with the destination MAC address of the router. 
- The Frame reaches the router, which strips the Frame(L2) header to read the destination IP address. It then checks its routing table (pre-populated) to determine the next hop IP. It then create a **new Frame** by adding a header with the destination MAC corresponding to the next Router's MAC (performing ARP if necessary)
- This process repeats until the Frame reaches the server. The Frame header, followed by the Segment header are then stripped. The record is then decrypted and data passed to the application matching the destination port address for processing. 

**References**\
[Quora - How a computer know the MAC address of the receiver](https://www.quora.com/How-does-a-computer-know-the-MAC-address-of-its-receiver)\
[What is an ARP table](https://www.auvik.com/franklyit/blog/what-is-an-arp-table/)\
[Launch School - Encapsulation and Decapsulation in Packet Routing](https://launchschool.com/posts/b8c4153b)

[Back to Top](#section-links)


## What is the web?

The web (aka World Wide Web) is a service that can be accessed via the internet.
It is vast information system comprised of resources that are accessible with
the use of an URL. Applications such as browsers are able to interact with
these resources through the use of HTTP. The Internet provides both the physical
infrastructure and protocols required to facilitate the transfer of these resource
from one device to another across the world.

[Back to Top](#section-links)


## What is a resource?
[URL - What are resources](12_urls.md#what-are-resources)

[Back to Top](#section-links)


## What is a Client-Server model?
- A client-server is a type of networking model where two processes
communicating over a network each take on a specific role.
- The client is the party initiating the communication. It is responsible
for issuing requests to a server. The request could be to retrieve a resource
or for an action to be carried out on the server. It is also responsible for
processing server responses and rendering contents.

- The server is usually a computer hosting the resources. It will process 
incoming requests and then send a response to the client informing the client
the status of that request and any accompanying resource, when applicable.
- For web service, the client could be a browser or a GUI or terminal based
HTTP tool.
- The server is a simplified model. In reality, server-side infrastructure
can be highly complex, with multiple components (e.g. web server, application
server and database) distributed over multiple machines supported by 
intermediary machines e.g. load balancers.

![Client and Server](images/33a_client_server.png)

[Back to Top](#section-links)


## Server Components
- The three primary pieces of server components are the web server, the
application server, and the data store.
- Web server = responds to requests for static resources, i.e. resources that
do not require data processing (like CSS files)
- Application server = handling more complicated requests, such as those that
contain application or business logic. Any server-side application code lives here.
- Data store = some kind of storage construct that can save data for later
retrieval and processing.

![Server Components](images/33b_server_components.png)

[Back to Top](#section-links)
