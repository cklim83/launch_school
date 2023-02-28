# Images

## Section Links
[Image Types](#image-types)\
[Adding Images to Web Pages](#adding-images-to-web-pages)\
[Figure and Figcaption](#figure-and-figcaption)\
[Images as Links](#images-as-links)\
[Background Images](#background-images)

---

## Image Types
The three most common image formats seen on the internet are `jpg`, `png` and `gif`.

### JPG
- `JPG` uses **lossy compression**: they lose information in exchange for file size reduction. They provide an exceptional balance of image quality and compression.
- Each edit of `jpg` results in information loss. Thus, the more times a `jpg` image is updated, the more details are lost.

### PNG
- `PNG` uses non-lossy compression. Because of this, the image quality is better but file size tends to be much larger.
- `PNG`s also provide both **single-color and alpha transparency**: one can see the background behind an image while still viewing the image's main subject. This feature is useful with logos, icons and line drawings.
- `PNG`s are ideal for images that need all their detail, transparency or must support >16.7 million colors.

### GIF
- `GIF`s are suitable for small images used in user interface icons in an application.
- They have limited color range (256 colors) but small file sizes, making them perfect for images where size, detail and broad color palette aren't significant.

[Back to Top](#section-links)


## Adding Images to Web Pages
- `<img>` is a self-closing tag that tells the browser to load and display a foreground image from a separate source. It has four attributes of interest:
	- The `src` attribute is mandatory and tells the browser where to find the image. The path can be relative, root-relative or absolute.
	- The `alt` attribute is optional, but preferred to be furnished. It describes the content of the image and is used by search engines to index images and is important in search engine optimisation. It's value is display when the browser fail to load an image. It is also used by screen readers that read web pages aloud for vision impaired persons. If `alt` attribute is ommitted, the browser can still render the image but the W3C validation will fail.
	- `width` and `height` attributes are also optional. They provide the width and height of the image in pixels. CSS width and height properties will override the HTML attributes in the rendered page.

```html
<img src="lucrezia.jpg" alt="Da Vinci's Smarter Sister, Lucrezia"
     width="800" height="600">
```

[Back to Top](#section-links)


## Figure and Figcaption
- The `figure` element is used to enclose media (image, video or audio) and accompanying content such as `figcaption`. Semantically, it confers relationship between the media and caption, something that using `div` enclosing `img` and `p` doesn't provide
- `figure` and `figcaption` is not needed with every image, especially if they are not reference else where in the text. `figcaption` is only needed if we need caption.
- `figcaption` can be placed above or below the media as needed.
```html
<figure>
  <img src="masthead.jpg" alt="Sunset over the forest">
  <figcaption>The sun sets over the dense forest</figcaption>
</figure>
```

[Back to Top](#section-links)


## Images as Links
- We can make an image clickable by nesting it within an `a` element. 
- Values for `href` and `src` are typically different but can also be the same.
```html
<a href="url-of-link" target="_blank">
  <img src="url-of-image" alt="alt-text">
</a>
```

[Back to Top](#section-links)


## Background Images
- We can add background images to a page or element using the CSS `background` or `background-image` property.
- Background images appear behind the content of the element and its descendents
- For background images that apply to an entire page, we can specify them using the `body` selector. Background images can also be applied to any selector.
- We can use the `background-size` property to repeat the image, scale it etc.

```css
body {
  background-image:
    url(http://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/gradient-background.png);
  background-size: cover;
}
```

[Back to Top](#section-links)