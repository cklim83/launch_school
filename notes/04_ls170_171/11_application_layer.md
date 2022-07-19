# The Application Layer
The application layer here is **not referring to the application itself**, but
rather a set of **protocols** that provide communication services 
**to applications**.

Networked applications can interact beyond Application layer protocols.
Many applications are also known to interact with Transport layer protocols 
e.g. by opening a TCP socket. However, that is about as far as they go and 
it is rare for applications to interact directly with protocols below the
Transport layer.

Application layer protocols focus on the **structure of a message and the data
it should contain**. They then rely on the protocols operating in lower layers
to deliver those messages to where they are supposed to go.

Setting a message structure can be viewed as dictating the communication
syntax between applications. There are different application protocols, each
catering to unique requirements of the applications they are supporting:
- **SMTP** along with either **POP or IMAP** for email exchanges between client
and server
- **HTTP** between web browser (client) and web server
- **FTP** for file transfer between client and server

## HTTP and the Web
- The Internet is essentially a network of networks
- The World Wide Web, or **web** for short, is a **service** accessed over
the Internet. It is a vast information system comprising resources 
navigable by an `URL` (Uniform Resource Locator). `HTTP` is the primary
means applications interact with the resources which make up the web.

## HTML URI and HTTP
**Hypertext Markup Language (HTML)** was the means to **standardize how web
resources are structured and presented**. Early web materials are largely text
based so earliest versions of HTTP only support basic components such as
headings, paragraphs and lists to structure text. It also support anchor
elements <A>, which uses a href attribute to along resources to be linked
together.

**A Uniform Resource Identifier (URI)**, is a **string identifier for a
particular resource**. The terms URI and URL (Uniform Resource Locator) are
often used interchangeably but are actually different: 
- A URL is definitely a URI but a URI need not be a URL. 
- A URI is essentially a unique resource identifier (e.g. ISBN number for a
book) but it need not help us locate where the resource is. A URL on the other
hand helps us locate the resource.

**Hypertext Transfer Protocol (HTTP)** is the set of rules which provide
uniformity to **how resources on the web are transferred between applications**.

HTML and HTTP have both been through several iterations, and resources on the
web are no longer limited to simple text documents but now include things such
as images, video, audio files, dynamically generated content, and much more.