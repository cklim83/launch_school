# Network Fundamentals Study Guide
## Section Links
[What is the internet and how it works?](#what-is-the-internet-and-how-it-works)\
[Understand the characteristics of the physical network, such as latency and bandwidth](#understand-the-characteristics-of-the-physical-network-such-as-latency-and-bandwidth)\
[Have a basic understanding of how lower level protocols operate](#have-a-basic-understanding-of-how-lower-level-protocols-operate)\
[Know what an IP address is and what a port number is](#know-what-an-ip-address-is-and-what-a-port-number-is)\
[Have an understanding of how DNS works](#have-an-understanding-of-how-dns-works)\
[Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model](#understand-the-client-server-model-of-web-interactions-and-the-role-of-http-as-a-protocol-within-that-model)\
[Have a clear understanding of the TCP and UDP protocols, their similarities and differences](#have-a-clear-understanding-of-the-tcp-and-udp-protocols-their-similarities-and-differences)\
[Have a broad understanding of the three-way handshake and its purpose](#have-a-broad-understanding-of-the-three-way-handshake-and-its-purpose)\
[Have a broad understanding of flow control and congestion avoidance](#have-a-broad-understanding-of-flow-control-and-congestion-avoidance)\
[Be able to identify the components of a URL, including query strings](#be-able-to-identify-the-components-of-a-url-including-query-strings)\
[Be able to construct a valid URL](#be-able-to-construct-a-valid-url)\
[Have an understanding of what URL encoding is and when it might be used](#have-an-understanding-of-what-url-encoding-is-and-when-it-might-be-used)\
[Be able to explain what HTTP requests and responses are, and identify the components of each](#be-able-to-explain-what-http-requests-and-responses-are-and-identify-the-components-of-each)\
[Be able to describe the HTTP request/response cycle](#be-able-to-describe-the-http-request-response-cycle)\
[Be able to explain what status codes are, and provide examples of different status code types](#be-able-to-explain-what-status-codes-are-and-provide-examples-of-different-status-code-types)\
[Understand what is meant by 'state' in the context of the web, and be able to explain some techniques that are used to simulate state](#understand-what-is-meant-by-state-in-the-context-of-the-web-and-be-able-to-explain-some-techniques-that-are-used-to-simulate-state)\
[Explain the difference between `GET` and `POST`, and know when to choose each](#explain-the-difference-between-get-and-post-and-know-when-to-choose-each)\
[Have an understanding of various security risks that can affect HTTP, and be able to outline measures that can be used to mitigate against these risks](#have-an-understanding-of-various-security-risks-that-can-affect-http-and-be-able-to-outline-measures-that-can-be-used-to-mitigate-against-these-risks)\
[Be aware of the different services that TLS can provide, and have a broad understanding of each of those services](#be-aware-of-the-different-services-that-tls-can-provide-and-have-a-broad-understanding-of-each-of-those-services)

---

## The Internet

### What is the internet and how it works?
The internet is a "network of networks". A network is any plurality of devices that are connected by network infrastructure (e.g. fiber optics cables, routers, cellular towers, switches and ethernet cables) so that they can exchange data. Devices in close proximity connected to hub/switch forms a local area network (LAN). Lots of these LANs are then interconnected via routers to form the Internet. When we say "The Internet", we are describing both the physical infrastructure that facilitates this interconnectivity, and the protocols that govern its functionality.

**What happens when we enter a URL in our laptop browser?**
- Our browser sends a request to the DNS to resolve the domain name into its IP address
- It then sends a request to the server hosting the site to open a TCP connection. A three-way handshake ensues to open a TCP connection
- If the site is running on HTTPS, TLS handshake then ensues to setup a secure connection.
- The browser than sends a HTTP request to the server to request for that webpage. 
- The server processes the request and sends a response with a 3-digit code and text indicating the status of that request. It could be
	- 200 OK, indicating the request was successfully processed. The accompanying HTML file will be in the response body.
	- 3XX Found, indicating the resource has be relocated. A location header will indicate the new location of the resource.
	- 404 Not Found. The requested resources are not found. Client have provided an invalid url.
	- 500 Internal Server Error. Server has encountered an error. 
- The browser will process the response and render the result to the user.

**How does a message flow down the layers from the sender, across the network to the server and up the layers to the server application?**
- Browser creates a HTTP request
- TLS encryptes the HTTP request and encapsulates the data into a Record (with a MAC field for integrity checks)
- TCP in the transport layer encapsulates the Record with a header that includes source and destination port number (extracted from URL) and sequence numbers amongst other fields to form a Segment
- IP encapsulates the TCP Segment with a header that includes the source and destination IP address (resolved from the DNS using the domain name in URL) to form a Packet. 
- Ethernet encapsulates the Packet in a **Frame** by adding header that includes source and destination MAC address.
	- Client computer does not have the MAC address of the server. Nonetheless, it recognise the destination IP address belongs to another network (different subnet mask) and know that it need to forward the Frame to its default gateway (local router). 
	- Although it knows the IP address of the local router, it does not have its MAC address in its own ARP table. To get it, it broadcast a ARP request asking for the MAC address of the device having the IP address of default gateway. The router responds to the request with its own MAC address. The host update its own ARP table with the MAC address of the router. It then construct a Frame with the destination MAC address of the router. 
- The Frame reaches the router, which strips the Frame(L2) header to read the destination IP address. It then checks its routing table (pre-populated) to determine the next hop IP. It then create a **new Frame** by adding a header with the destination MAC corresponding to the next Router's MAC (performing ARP if necessary)
- This process repeats until the Frame reaches the server. The Frame header, followed by the Segment header are then stripped. The record is then decrypted and data passed to the application matching the destination port address for processing. 

**Extra Notes**
- A large complex network of fiber optical cables form the backbone of the Internet. These cables straddle long swathes of land and sea connecting countries. They carry data in the form of light impulses from data centers to one's doorstep where they are connected to a router. The router converts these light signals to electrical signals and EM waves. A laptop can then receive the electrical signals from router via an Ethernet cable or the EM waves via Wi-Fi. If one is accessing the Internet using cellular network, from the optical cable the signal has to be sent to a cell tower. And from the cell tower, the signal reaches one's phone/mobile device in the form of electromagnetic waves.
- These infrastructure are collectively owned and operated by large global organisations such as AT&T, Orange, Google and Verizon. 
- Since the internet is a global network, it is important to have an organisation to manage things like IP address assignment, domain name registration etc. This is all managed by an institution called Internet Corportion for Assigned Names and Numbers (ICANN) located in the USA.
- The data e.g. a youtube video one is requesting from a Data Center is sent  in the form of huge collection of zeros and ones. These zeros and ones are chopped up into small chunks known as packets and transmitted. Along with the bits of the video, each packet also consists of the sequence number and the IP addresses of the server and client device. With this information, the packets are routed towards the client device. It is not necessary that all packets are routed the same path and each packet independently takes the best route available at that time. Upon reaching the client device, the packets are reassembled according to their sequence number. If any packets are lost in the transfer, an acknowledgement is sent from the client to resend the lost packets.
- The Internet supports not just HTTP but also other protocols such as SMTP (email), FTP (file transfer) etc.
- Servers differ from Clients (devices we used to access the web) in that servers are directly connected to Internet but clients are not. Clients do so via an Internet Service Provider.

[What is the Internet](01_internet.md#what-is-the-internet)\
[What Happens When You Enter a URL in a Browser and Press Enter?](01_internet.md#what-happens-when-you-enter-a-url-in-a-browser-and-press-enter)\
[How Internet Works - Mozilla](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/How_does_the_Internet_work)\
[Video - Internet in 5 Minutes](https://www.youtube.com/watch?v=7_LPdttKXPc)\
[Video - Detailed Explanation of How the Internet Works](https://www.youtube.com/watch?v=x3c1ih2NJEg)

[Back to Top](#section-links)


### Understand the characteristics of the physical network, such as latency and bandwidth
The performance of the physical network can be defined by its Latency and Bandwidth. 

**Latency** refers to the time required to move data from one point to another point in the network. It is a measure of delay. Components of latency includes:
- Propagation delay: The time to move from point A to B based on the signal and transmission medium governed by physics.
- Transmission delay: Time to push data from one link to another on the network. A link could be a cable or a network device.
- Processing delay: Processing time to determine which link to forward data on the network.
- Queuing delay: Network can only process certain amount of data. Excess data have to queue in a buffer to wait for its turn.

**Bandwidth** refers to the maximum amount of data that can sent per unit time. It is measured in bits per second. It measures the capacity of a network and is akin to the number of lanes on a road. Bandwith varies across the network. It is higher at the core network but lower at the last mile (endpoint connecting home or buildings).

[Characteristics of a Physical Network](04_physical_layer.md#characteristics-of-a-physical-network)\
[Components of Latency](04_physical_layer.md#components-of-latency)\
[Bandwidth](04_physical_layer.md#bandwidth)

[Back to Top](#section-links)


### Have a basic understanding of how lower level protocols operate
The link/data link layer is the interface between the physical network and the network/internet layer above it. It is responsible for identifying the device we want to send the data. **Ethernet** is the most common protocol operating in this layer. It helps to **provide structure** to binary data by encapsulating packets from network/internet layer into **Frames**. One of the key headers of a Frame is the **MAC address**. This is in a form of six two-digit hexadecimal numbers e.g. `00:40:96:9d:68:0a`  which are **fixed and uniquely identifies** each network device. They help network devices **identify the right recipient within a network**. 

[Ethernet Frames](05_data_link_layer.md#ethernet-frames)\
[MAC Addressing](05_data_link_layer.md#mac-addressing)

[Back to Top](#section-links)


### Know what an IP address is and what a port number is
An IP address is an address that **uniquely identifies** a device connected to the Internet. Similar to how postal addresses are used for the delivery of parcels and posts, an IP address is **used for the delivery of data packets** on the Internet. It has two versions IPv4 and IPv6. IPv4 is 32-bits in length and is divided into four sections of eight bits. When converted from binary to decimal, each section can take on a value between 0 and 255. An example IPv4 address is `109.156.255.1`. IPv6 is an extension of IPv4 to accommodate the growing number of connected devices. It is 128-bits in length arranged in 8 x 16-bits blocks.

A port number is an **integer that identifies a specific process** running on a host. It is used for the **delivery of messages** between web applications. Port values can range from 0 - 65535. These values are assigned based on the following rules:
- 0 - 1023: **Well known ports** for common networking services e.g. 80 for HTTP, 443 for HTTPS, 20 and 21 for FTP, 25 for SMTP.
- 1024 - 49161: Ports registered by **private entities** such as Microsoft, IBM, Cisco for their services.
- 49152 - 65535: dynamic ports for temporal allocations.

Collectively, IP address and port numbers allow multiple processes running concurrently on a host to communicate with other processes on the Internet.

[Back to Top](#section-links)


### Have an understanding of how DNS works
A Domain Name System helps resolve a domain name to its corresponding IP address. It does this by keeping records mapping domain names to their corresponding IP addresses in their servers. No single DNS server maintain records for all domain names in the world. Instead, these records are distributed across DNS servers organised in a hierarchical structure on the Internet. When an user enters an Uniform Resource Locator (URL) in the address bar of a web browser, the browser will send a request to the DNS servers of its Internet Service Provider (ISP). The DNS servers will check its record and return the corresponding IP address. If that domain name is not found in its DNS servers, it will automatically reach out to other DNS servers and return with a result.

Note: Above scenario assumes there is no domain name - IP address record for that domain name on the host's DNS cache.

[Back to Top](#section-links)


### Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model
- A client-server is a type of networking model where two processes communicating over a network each take on a specific role.
- The client is the party initiating the communication. It is responsible for issuing requests to a server. The request could be to retrieve a resource from the server or for an action to be carried out on the server. It is also responsible for processing server responses and rendering contents.
- The server is usually a computer hosting the resources. It will process incoming requests and then send a response to the client informing the client the status of that request and any accompanying resource, when applicable.
- HTTP is an application layer protocol that operates in a client-server model. It helps govern 
	- how requests for resources on the web are made and how they should be responded to.
	- how messages should be structured so that they can be understood by the recipient.

[Client Server Model](01_internet.md#what-is-a-client-server-model)\
[HTTP](13_http.md#what-is-http)

[Back to Top](#section-links)


## TCP & UDP

### Have a clear understanding of the TCP and UDP protocols, their similarities and differences

**Similarities**
Both are protocols working on the transport layer in the layered networking model that enables exchange of messages between applications 

**Differences**
- TCP is a connection - orientated protocol while UDP is a connectionless protocol. This means that before application data can be exchanged under TCP, a connection first has to be established using a three-way handshake involving `SYN`, `ACK-SYN`, `ACK` messages between client and server. This introduced some performance overhead: minimum of 1 round-trip delay, assuming no loss before application data can be exchanged. UDP does not need a connection to be setup and can start sending application data immediately.
- TCP guarantees message delivery through message acknowledgement and retransmission. Any message sent by the sender has to be acknowledged by the recipient within a prescribed time window. Otherwise, the message is assumed lost and will be resent by the sender. UDP does not guarantee message delivery.
- TCP ensures in-order message delivery. This is achieved by having `sequence number` field in the TCP header so that the recipient knows the relative position of each TCP segment and can then organise received messages in the right order. UDP does not ensure in-order message delivery.
- TCP has flow control mechanism to prevent a sender from overwhelming a receiver by sending too much data at once. This is done by each party dynamically updating the other the maximum amount of data it can handle using the `window` field in the TCP header. UDP does not offer flow control.
- TCP also has built-in congestion avoidance. It does this by monitoring the rate of retransmission and reducing the size of transmission window if the rate is too high. UDP does not have congestion avoidance mechanism.

Overall, TCP's many critical features: reliability, in-order delivery, flow control and congestion avoidance makes it a core protocol for most applications on the Internet. Nevertheless, due to UDP simple and light-weight construct, it offers speed and flexibility and is suitable for applications that requires speed (low latency) and can tolerate a certain amount of data losses.

[TCP](04_ls170_171/09_tcp.md)\
[UDP](10_udp.md)

[Back to Top](#section-links)


### Have a broad understanding of the three-way handshake and its purpose
A three-way handshake is used to **establish a connection** between a client and server **before application data can be exchanged**. 
- It begins with the client sending `SYN` segment to the server. After sending this message, the client transit to a `SYN-SENT` state.
- The server, who is listening on its port will transit to a `SYN-Received` state upon receipt of the `SYN` segment. It then sends a `SYN-ACK` segment back to the client as acknowledgement.
- The client, upon receiving the `SYN-ACK` segment, transits to a `Established` state and sends a `ACK` segment back to server in response. It can start sending application data immediately after sending the `ACK` segment.
- The server will also transit to `Established` state. Connection is fully establiahed on both ends at this point and the server can also start sending application data.

[TCP Handshake](04_ls170_171/09_tcp.md#tcp-handshake)

[Back to Top](#section-links)


### Have a broad understanding of flow control and congestion avoidance

See previous question for summary. Refer to links for details.

[Flow Control](09_tcp.md#flow-control)\
[Congestion Avoidance](09_tcp.md#congestion-avoidance)

[Back to Top](#section-links)


## URLs

### Be able to identify the components of a URL, including query strings

`http://www.example.com:775?item=book&price=50` is made of:
- `http`: an **URL scheme**, that identifies the protocol group in use, 
- `example.com`: a **domain name**, 
- `775`: a **port number** (**optional** and only if it deviates from the default), 
- `/`: a **path** (**optional**) that **identifies the resource**. Note: It is more accurate
to say "a path identifies the resource" rather than a "path shows the location of a
resource". This is because modern webpages are often dynamically created meaning the page
is created and not stored on the server. We should also avoid saying the server searches for
the resource using the path because these dynamic pages are created on demand and can't be
searched for.
- `item=book&price=50`: **query string** (**optional** and consists of query parameters in the form of `name=value`)

[Components of a URL](12_urls.md#components-of-a-url)

[Back to Top](#section-links)


### Be able to construct a valid URL

An URL should only contain the following **allowable characters**
| Set | Characters | URL usage |
|---|---|---|
| Alphanumeric | `A-Z`, `a-z`, `0-9` | Text strings, scheme usage (http), port (8080) etc. |
| Unreserved | `-_.~` | Text strings |
| Reserved | `!*'();:@&=+$,/?%#[]` | Control characters and/or Text strings|

If any characters outside this list or any reserved characters are to be use literally, they have to be encoded.

[Back to Top](#section-links)


### Have an understanding of what URL encoding is and when it might be used

Some characters cannot be part of a URL and some characters have a special meaning in an URL. URL encoding is a technique to translate such characters before they are sent to a web server. 

The three reasons to encode a character in an URL are:
- They have no corresponding character within the standard ASCII character set 
i.e. **not in** list of allowable characters above
  - e.g. foreign language characters `上海中國`
- The use of the character is unsafe because it may be misinterpreted, or even
possibly modified by some systems. 
  - e.g. `%` is unsafe because it can be used for encoding other characters. 
- The character is reserved for special use within the URL scheme but that we
want to use literally i.e. use without its special meaning
  - e.g. we want to use the string "`time+space`" rather than its special meaning where `+` is interpreted as space i.e. `time space` 

To encode, we replace the character with `%` and a two-character hex value corresponding to their UTF-8/[ASCII](https://www.asciitable.com/) character. Common encoded characters:
| Character | Hex Value | URL Example |
|---|---|---|
| Space | 20 | `http://www.thedesignshop.com/shops/tommy%20hilfiger.html` |
| ! | 21 | `http://www.thedesignshop.com/moredesigns%21.html` |
| + | 2B | `http://www.thedesignshop.com/shops/spencer%2B.html` |
| # | 23 | `http://www.thedesignshop.com/%23somequotes%23.html` |

**Other Examples**
| String | URL-Encoded form |
|---|---|
|`上海+中國` | `%E4%B8%8A%E6%B5%B7%2B%E4%B8%AD%E5%9C%8B` |
| `? and the Mysterians` | `%3F+and+the+Mysterians` or `%3F%20and%20the%20Mysterians` |

[Reference - Google URL Encoding](https://developers.google.com/maps/url-encoding)

[Back to Top](#section-links)


## HTTP and the Request/Response Cycle

### Be able to explain what HTTP requests and responses are, and identify the components of each

**HTTP Request**
- A HTTP request is a text-based message sent from a client to a server to
access a resource on the server or perform an action on the server end.
- A HTTP request is sent upon an event such as entering an URL in a browser
address bar and pressing enter, clicking on a page link, submitting a web
form or interacting with web elements in a way designed to send out a request
(e.g. hover over an item may retrieve a preview)

**Components of a HTTP Request**
- A **mandatory request line** comprising a request **method**, **path**,
and **protocol version**. e.g. `GET / HTTP/1.1`
- A set of **headers** (name-value pairs) to provide information
about client to server. Note: At a minimum, the `Host` header is
**mandatory** as of HTTP/1.1
- An **optional body**, used mainly by POST methods.

**HTTP Response**
- HTTP responses are text-based messages sent from the server to the client in
respond to the client's request. They either:
	- Provide the client with the resource required
	- Inform the client that the action it requested was carried out
	- Inform the client that an error occurred in the process

**Components of a HTTP Response**
- A **mandatory** response line containing **Status Code**, **Status Text**
and **Protocol Version**. The **status code** is a three-digit number that the
server sends back after receiving a request to signify the status of the
request while the accompanying **status text** gives more description of
the status code
- An **optional** set of **headers** to provide information about server
- An **optional** body containing the requested resource e.g. HTML.

[HTTP Request](13_http.md#http-request)\
[HTTP Response](13_http.md#http-response)

[Back to Top](#section-links)


### Be able to describe the HTTP request/response cycle
- The HTTP request-response cycle describes the way client and server behaves to
facilitate the exchange of information.
- It begins with the client making an HTTP request.
	- This typically involves a browser issuing a HTTP request to a server in
	response to some kind of user action or event (i.e. typing a url into an
	address bar, clicking a link, submitting a form, etc).
    - The request consists of, at minimum, a request line consists of the method
    (i.e. GET or POST), the host and the path.
    - The request is sent off to the server by means of the lower layer network
    protocols.
- When the server receives the request, it will analyze it.
    - This may include actions like verifying the user's session or loading any
    necessary data from a database
- Once the server has analysed the request, it will issue a response
    - This includes the status field, a numeric field that tells if the response
    was successful, headers which contain important meta-data that helps the
    client process the response, and the body which contains the raw data of the
    resource being sent.
- When the browser receives the response, it will process the information within
and render the resource in a user-friendly manner.

[HTTP Request Response Cycle](13_http.md#the-http-request-response-cycle)

[Back to Top](#section-links)


### Be able to explain what status codes are, and provide examples of different status code types
- Status Codes are 3-digit number sent by the server to indicate the status of a request. 
- The accompanying status text gives more description of the status code. 

**Common response status codes and their meanings**:
| Status Code | Status Text | Meaning |
| --- | --- | --- | 
| 200 | OK | The request was handled successfully |
| 302 | Found | The requested resource has changed location temporarily. Has `Location` header with the new address for redirection. All 300 level codes indicate some redirect status |
| 404 | Not Found | The requested resources cannot be found. All 400 level codes indicate various client errors |
| 500 | Internal Server Error | The server has encountered a generic error. All 500 level codes indicate server side errors |

[HTTP Response](13_http.md#http-response)

[Back to Top](#section-links)


### Understand what is meant by 'state' in the context of the web, and be able to explain some techniques that are used to simulate state

A "stateful" web application is one that maintains knowledge of past interactions.
- This might include keeping track of individual user accounts and maintain a "logged in" status accross multiple resource requests and refreshes e.g. Facebook.
- Stateful apps can also keep track of items a user has placed in an online "shopping cart", even over multiple days

The use of sessions and cookies can help a web application simulate state. When a user first visits a website, the server generates a new session with a unique session ID. Any user interaction on the website will be logged on the server end with the session ID. 

The server then sends the session ID in the form of a cookie to the user's browser with an expiry date in its response. Subsequent HTTP requests sent by that browser will have that session ID appended as one of its header field. The server will then process these requests, check for the session ID and use it to retrieve the past interactions and recreate the state of that client e.g. logged in status, items added to shopping cart, as its response. This gives the client the impression that the website remembers all its past actions. 

[Stateful Web Applications](13_http.md#stateful-web-applications)\
[Sessions and Cookies](13_http.md#sessions-and-cookies)

[Back to Top](#section-links)


### Explain the difference between `GET` and `POST`, and know when to choose each
- A `GET` request is used to **retrieve resource** from the server. When we enter a url in the address bar or when we click on a link, we are issuing a `GET` request.
- A `GET` request can also send data to a server using query strings in url. However, these have length limits and can expose sensitive information.
- A `POST` request is used to **send data** to a server or to initiate an action on the server end. We issue a `POST` request when we submit a web form.
- A `POST` request allow us to send larger data (e.g. images and videos).
- Since `POST` requests use the body rather than the URL to append the data, they are more suitable to send sensitive information like username and password.

[GET and POST Request](13_http.md#get-and-post-request-methods)

[Back to Top](#section-links)


## Security

### Have an understanding of various security risks that can affect HTTP, and be able to outline measures that can be used to mitigate against these risks

**Exposure of Sensitive Information**
- HTTP requests and responses are transferred in **plain text** and are inherently insecure. Using packet sniffing and other techniques, a hacker could intercept the data exchanged and gain access to sensitive information.
- For security reasons, most web applications now opt for the **https** scheme instead of http.
- HTTPS uses the **Transport Layer Security (TLS) protocol** in the lower layer and is also known as HTTP over TLS.
- With HTTPS, all requests and responses are **encrypted** before they are transported on the network.

**Session Hijacking**
- As web applications often base their user authentication on cookies included in HTTP requests, this may make them vulnerable to **session hijacking**. 
- A user that has logged onto say a banking application but is also browsing a malicious site may be subjected to an attack by a script hosted on the malicious site. The script could issue a request to the banking application and since the browser will automatically include the cookie issued by the banking application in all requests sent to it, the malicious site can gain unauthorized access.
- Adopting the **same-origin policy** could prevent this attack since the attacker and the banking application share a different origin, the attacker access to the banking app will be restricted.
- Other ways to reduce the chance of session hijacking includes:
	- Resetting session frequently. This can be done by getting users to authenticate before granting access to sensitive areas. Sessions reset post authentication and the previous session ID, even if compromised, becomes invalidated.
	- Set expiration time on sessions to narrow access window.
	- Use HTTPS to prevent attacker from gaining access to unencrypted session ID

**Cross Site Scripting (XSS)**
- Cross-site scripting (also known as XSS) is a web security vulnerability that could happen when we allow users to **input HTML or Javascript that to a page for display (e.g. a comment)**.
- Users loading the compromised page will **execute the malicious code on their browswer.**
- To avoid this, we could:
	- Sanitize user input to eliminate problematic inputs such as `<script>` tags, or disallow HTML and Javascript input altogether
	- Escape all user input data when displaying it so that browser do not interpret them as code. e.g. `<p>Hello World!<\p>` to `&lt;p&gt;Hello World!&lt;\p&gt;` to display it as plaintext. [HTML entities](https://entitycode.com/#math-content)

[HTTPS](4_security.md#hypertext-transfer-protocol-secure-https)\
[Same-Origin Policy](14_security.md#same-origin-policy)\
[Session Hijacking](14_security.md#session-hijacking)\
[XSS](14_security.md#cross-site-scripting-xss)

[Back to Top](#section-links)


### Be aware of the different services that TLS can provide, and have a broad understanding of each of those services

Transport Layer Security (TLS) operates between HTTP and TCP and provides **encryption**, **authentication** and **integrity** services. 

**Encryption**
TLS encryption involves encoding messages exchanged between client and server so that transfered content can only be read by intended party. Even if any messages were to be hijacked by a hacker, it would not be able to make sense of it since it would not be able to decrypt the message. 

A secure communication channel is established following a TLS handshake. During the process, the client and server will
- Specify which version of TLS to use
- Decide which cipher suites to use
- Authenticate the identity of the server
- Securely exchange a symmetric key using asymmetric encryption
  - Asymmetric key encryption is used to securely exchange a pre-cursor between client and server
  which is then used to generate a common symmetric key.

After TLS handshake, all messages exchanged between client and server will be encrypted using the symmetric key 
before transfer. Upon receipt, the recipient will use the common key to decrypt the message before processing the content.

**Authentication**
TLS authentication allows the client to verify the identity of the server. It does this in two steps:
1. Verify the server is the owner of the SSL certificate.
2. Verify the certificate is issued by a trusted source i.e. a higher level certificate authority.

To confirm the server is indeed the owner of the certificate:
- The server will send its security certificate which includes its public key to the client. 
- The server will also send over a message containing some source data and a digital signature formed by encrypting the source data with its own private key. 
- The client will then decrypt the digital signature using the server's public key and compare it with the source data. If they matches, it can be sure the server **owns the certificate**. 

A **certificate authority** is a trusted organization that verifies websites so that you know who you’re communicating with online. They issue site certificates to websites that can pass their identification tests. They are a key stakeholder in the authentication service offered by TLS.

To confirm the certificate is issued by a trusted certificate authority,
- The client can will look up the certificate path to find the intermediate CA and its certificate. 
- It then uses the public key of the Intermediate CA included in its certificate and use it to decrypt the intermediate CA's signature included in the server's site certificate and compare with the source data. If it matches, we can confirm the site certification is indeed issued by the Intermediate CA.
- We can go up the hierarchy tree and verify that the intermediate CA's certificate is indeed issued by the root CA, which belongs to a small group of most trusted source. This completes the chain of trust system since a root CA signs its own certificate.

**Integrity**
The TLS integrity service helps ensure that received messages has not been tampered during its journey from source to destination. This is achieved through the use of a MAC field in the PDU of TLS, a record. 
- The sender creates the MAC for a record by applying a pre-agreed hash algorithm and hash value in the Cipher Suite on a subset of the data payload.
- The sender then encypted the data payload using the symmetric key (as part of the encryption process), and encapsulate it into a TLS record and hand it to the transport layer to be transferred to other party
- The recipient decrypts the data payload of the received TLS record using the symmetric key, then use the pre-agreed hashing algorithm and hash value on subset of payload to recreate the MAC. If the two MACs match, message is not tampered.

[TLS Encryption](14_security.md#encryption)\
[TLS Authentication](14_security.md#tls-authentication)\
[TLS Integrity](14_security.md#tls-integrity)

[Back to Top](#section-links)
