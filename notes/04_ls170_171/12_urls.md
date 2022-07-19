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
- URL encoding is a technique that replaces characters that aren't allowed
in a URL with an ASCII code.
- URL only allow certain characters in the standard [128-character ASCII character set](https://en.wikipedia.org/wiki/ASCII).
- Characters **must be encoded** if:
  1. They have **no corresponding character** within the standard ASCII character
  set
  2. Use of character is **unsafe as it may be misinterpreted**. E.g. `%` is
  unsafe as it is used for encoding other characters. Other examples include
  space, quotation marks, `#`, `<`, `>`, `{`, `}`, `[`, `]` and `~` among others.
  3. Character reserved for special use in URL scheme. E.g. `/`, `?`, `:`, `@`,
  `&` as they all have special meaning in an url.

- Only alphanumeric and `$-_.+!()"` and reserved characters in their reserved
purpose can be used unencoded in an URL.
- Encoding is done by replacing the character with `%` followed
by the two hexadecimal digits that represent the [ASCII code](https://www.asciitable.com/) of the
character. Common encoded characters and example URLS as follows:

| Character | ASCII Code | URL Example |
|---|---|---|
| Space | 20 | http://www.thedesignshop.com/shops/tommy%20hilfiger.html |
| ! | 21 | http://www.thedesignshop.com/moredesigns%21.html |
| + | 2B | http://www.thedesignshop.com/shops/spencer%2B.html |
| # | 23 | http://www.thedesignshop.com/%23somequotes%23.html |

[Back to Top](#section-links)
