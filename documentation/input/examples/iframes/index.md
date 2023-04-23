# IFrames
## Technical
Incunable is written to support static content, but using `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}` or `{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html{{rightcurlybracket}}{{rightcurlybracket}}`, dynamic content can be included through an iframe. If a user has Javascript disabled, a static fallback image will be displayed instead.

The difference between `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html{{rightcurlybracket}}{{rightcurlybracket}}` is that the former will insert the dynamic content as is, whereas the latter will insert it inside a frame and provide a caption, much like an `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`.

When using either `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}` or `{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html{{rightcurlybracket}}{{rightcurlybracket}}`, a Javascript file, called "iframe.js" is automatically created and inserted (via `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`). This file does two things:
* It replaces the fallback image with the given HTML page.
* It adds a listener for Messages, in order to set the iframe to the right size. This Message needs to be sent from somewhere in your Javascript code, and should be of the form `{{leftcurlybracket}}"id": "[id]", "width": width, "height": height{{rightcurlybracket}}`, where "[id]" must be the same value as the `id` argument to `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}`.

A Message can be sent for instance like this:
```
window.parent.postMessage({{leftcurlybracket}}"id": "map", "width": "300px", "height": "500px"{{rightcurlybracket}}, "*");
```

By sending a Message with the sizes, you can calculate the space needed to fit the content dynamically.

If there already is a file called "iframe.js" in the folder of the page, then no default script will be generated. Thus, you can overwrite the default behaviour with your own logic. In this case, you need to include this with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`. An example of this can be seen on the [includes page](includes.html).


## Example
Below are three boxes with colours. They are included as iframes, using `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html{{rightcurlybracket}}{{rightcurlybracket}}`. A script to broadcast the sizes of the iframes needs to be provided, that notifies the parent of their sizes ([size-broadcaster.js](iframes-files/size-broadcaster.js) and [orange-size-broadcaster.js](iframes-files/orange-size-broadcaster.js)). This allows for having custom code that gives the exact size needed.

If you disable Javascript, static fallback images will be used instead of the iframes.

Small blue box:
```
{{leftcurlybracket}}{{leftcurlybracket}}include-html {{pipe}}id=blue {{pipe}}file=blue.html {{pipe}}fallback=blue.png {{pipe}}fallback_text=Blue image{{rightcurlybracket}}{{rightcurlybracket}}
```
{{include-html |id=blue |file=blue.html |fallback=blue.png |fallback_text=Blue image}}

Medium yellow box:
```
{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html {{pipe}}id=yellow {{pipe}}file=yellow.html {{pipe}}fallback=yellow.png {{pipe}}fallback_text=Yellow image{{rightcurlybracket}}{{rightcurlybracket}}
```
{{include-framed-html |id=yellow |file=yellow.html |fallback=yellow.png |title=Yellow image in a frame}}

Big orange box:
```
{{leftcurlybracket}}{{leftcurlybracket}}include-html {{pipe}}id=orange {{pipe}}file=orange.html {{pipe}}fallback=orange.png {{pipe}}fallback_text=Orange image{{rightcurlybracket}}{{rightcurlybracket}}
```
{{include-html |id=orange |file=orange.html |fallback=orange.png |fallback_text=Orange image}}
