# Evolution of Network Technologies
## Section Links

[HTTP Developments](#http-developments)\
[Browser Networking APIs](#browser-networking-apis)

---

## HTTP Developments
- HTTP has changed considerably and is continuing to change
- Changes are focused on improving performance in response to ever increasing
demands of modern networked applications

  | Demands from Networked Applications | HTTP Version | Year Released | Features |
  |---|---|---|---|
  | Webpages mainly consists plain text documents and links | HTTP/0.9 | 1991 | Support only **`GET`** method, only path needed to reference resources, response is single hypertext document with **no headers** |
  | More content types like CSS, videos, scripts and images supported | HTTP/1.0 | 1991 - 1996 | First formalized standard. Added **headers to requests and responses**, including support for **status code**, **http version number** in request line and **content-type** field. Added **`POST`** method. Each connection tend to close after one request-response cycle | 
  | Complex pages referencing multiple resources. Multiple requests needed to load a single page | HTTP/1.1 | 1999 | Support connection reuse i.e. **keep-alive conection**: each connection can have multiple request-response cycles to avoid need for repeated TCP handshake, pipelining |
  | Pages have more visual data and are more interactive | HTTP/2 | 2015 | Supports **AJAX** for asychronous and more efficient document update, **multiplexing instead of pipelining** in data transfer to minimize delays due to head-of-line blocking caused by out-of-order arrivals | 
  | ... | HTTP/3 | Under development | QUIC as alternative to TCP and TLS for better performance | 

- Latency has a big impact on performance. Developers should be aware
and minimize latency through various optimisations
  - Minimize resource bloat, include only essential ones to reduce load list
  - Use data compression to reduce amount of data to be transferred
  - Reuse connections to minimize TCP handshakes
  - Minimize DNS lookups by hosting more external resources locally to reduce
  number of hostnames
  - Use faster DNS providers
  - Server caching to reduce costly page regeneration for commonly retrieved
  content. Balance between cache size and performance
  - Browser Document Aware Optimisation to prioritize resources with longest
  load time once document structure available
  - Browser Speculative Optimisation: Pre-empt user actions from past behavior
  so that page loading completes faster (e.g. open connection upon hover,
  pre-render frequently visited pages) 

[Back to Top](#section-links)


## Browser Networking APIs

### XMLHttpRequest (XHR) objects
- XHR objects are a key component of [AJAX](13_http.md#ajax) 
- XHR also support both **polling** and **long-polling**. The former sends
periodic requests to server to check for updates while the latter will just
send a single request and server response only when a update is available. 
Polling methods use request-response cyce and TCP connections are kept-alive
in both cases.
- XHR doesn't support one sided data streaming.

### Server-Sent Events (SSE) - One Way Messaging
- SSE is another browser networking API. Servers can send **real-time updates**
to the client **without the need to request for it**.
- Delivery happens over a long-live TCP connection. Once established,
the client no longer send any data over to the server using that connection
- Cons:
  - API is only for client-server model
  - Does not allow client to stream a large file to server (request streaming)
  - Streaming data have to be in UTF-8
  
### Web Socket
- A web socket API is **bidirectional communication model** i.e. non request-response
- It uses a persistent TCP connection and either side can independently send 
message to the other
- Provides low latency delivery of text and binary application data
- Cons:
  - The API is simple and will not provide state management, compression,
  caching and other optimisations to the web application.
  
## Peer to Peer Network Model
- Client-server is not the only networking model. Peer-to-peer (P2P) is an
alternative. Each participant is called a node and can act as both a client
or server.

Advantage of a P2P Model
- Network is more resilient since there is no central point of weakness 
(server)
- Since traffic need not be routed through a central point, data can flow
over shorter paths between direct participants, resulting in shorter latency
and making them suitable for real time communication e.g. voice or video calling

Disadvantage of a P2P Model
- **Network disovery is less straightforward**. Unlike a client server model,
where servers are assumed to be always-on, have fixed IPs easily found using a DNS,
nodes in a P2P network can go online or offline and their IPs can change.
- One way of discovering a network is through **flooding**. A message is broadcast
over the network for a specific number of hops. Nodes that receive the message
will then respond to that they be reachable. This is used in early file sharing
systems e.g. who has this file?
- **Distributed Hash Table (DHT)** containing key-value pairs (i.e. search item
- node id) is another way to discover nodes on a network. DHT covering
different network segments are then distributed among different nodes.
- P2P network can also exist in a **hybrid model**. Each node shares a
client-server relationship with a central server that allows them to discover
other nodes. Between nodes, the relationship is P2P.
- Other issues of a P2P network includes connection negotiation and 
establishment, security, performance and scaling.

## WebRTC
- WebRTC is a collection of standards, protocols, and APIs available in most
modern web browsers. 
- It abstracts away the complexities of establishing P2P communication between
nodes. 
- It uses UDP at the Transport layer and supports real-time communication (e.g.
voice or video calling) within browser that acts as a node).
- It uses other protocols for session establishment and maintenance, security,
congestion, flow control and certain level of reliability.

[Back to Top](#section-links)
