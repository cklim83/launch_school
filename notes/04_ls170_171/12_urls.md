# URL
## Section Links

[What is an URL?](#what-is-an-url)\
[What Are Resources?](#what-are-resources)\
[Components of a URL](#components-of-a-url)\
[Query Strings/Parameters](#query-stringsparameters)\
[URL Encoding](#url-encoding)

---

## What is an URL?
A Uniform Resource Locator (URL) is akin to an address that allows a user to
locate a resource on the Internet. It is a type of Uniform Resource Identifier
(URI).

[Back to Top](#section-links)


## What Are Resources?
Resource is a generic term for materials we can access using a URL on the
Internet. It can include images, videos, web pages and other files.

[Back to Top](#section-links)


## Components of a URL
```plaintext
http://www.example.com:88/home?item=book&price=50
```
- `http`: This is the URL **scheme**. It tells the client which protocol group
to use to make the request. Other schemes include `ftp`, `git`, `mailto`. 
A scheme is related to the protocol but they are not the same since it refer
to the protocol group but not the specific version.
- `www.example.com`: The **host** or the domain name. It tells the client
where the resource is hosted/located.
- `:88`: The **port** or port number. This only needs to be specified if we
are using something other than the default. The **default for http is 80**. 
The default for **https is port 443**.
- `/home/`: The **path**. It shows where on the host the resource is located.
This part of URL is optional.
- `?item=book&price=50`: The **query string** consists of **query
parameters**. It is used to send additional data (e.g. filter return data)
to the server and is optional.

[Back to Top](#section-links)


## Query Strings/Parameters
```plaintext
http://www.phoneshop.com?product=iphone&size=32gb&color=white
```
| Query String Component | Description |
|---|---|
| ? | A reserved character marking the start of the query string | 
| product=iphone | This is a parameter name/value pair |
| & | A reserved character to add more parameters to the query string |
| size=32gb | This is another name/value pair |
| color=while | This is another name/value pair |

**Because query strings are passed in via the URL, they are only used in HTTP
GET requests.** The query strings are available to the server and how they are
used is up to the receiving server.

While query strings are a good way to pass additional information to the
server, they have some limitations:
- **Query strings have a maximum length**. They are unsuitable if a lot of data
has to be passed.
- Name/value pairs are visible in the URL. Sensitive information like username
or password should not be passed in this way.
- Space and special characters like `&`, `=` cannot be used with query
strings. They have to be encoded.

[Back to Top](#section-links)


## URL Encoding
Some characters cannot be part of a URL and some characters have a special meaning in an URL. URL encoding is a technique to translate such characters before they are sent to a web server. 

An URL should only contain the following **allowable characters**
| Set | Characters | URL usage |
|---|---|---|
| Alphanumeric | `A-Z`, `a-z`, `0-9` | Text strings, scheme usage (http), port (8080) etc. |
| Unreserved | `-_.~` | Text strings |
| Reserved | `!*'();:@&=+$,/?%#[]` | Control characters and/or Text strings|

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
