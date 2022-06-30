# Includes

## Custom CSS and Javascript
This is a page that includes custom css (hence the background) and custom Javascript (hence the animation below).

```
{{leftcurlybracket}}{{leftcurlybracket}}include-css {{pipe}}file=custom.css{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}include-script {{pipe}}file=animation.js{{rightcurlybracket}}{{rightcurlybracket}}
```

{{include-css |file=custom.css}}
{{include-script |file=animation.js}}

## Included IFrame

Below is an iframe. By including an iframe via `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}`, the engine will also create a file called "iframe.js". Should you need to, you can overwrite it with a custom one, as is done here. Also, see the [iframes page](iframes.html).

```
{{leftcurlybracket}}{{leftcurlybracket}}include-script {{pipe}}file=iframe.js{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}include-html {{pipe}}file=iframe.html {{pipe}}fallback=delta.png {{pipe}}fallback_text=You need to enable Javascript to see this IFrame{{rightcurlybracket}}{{rightcurlybracket}}
```

{{include-script |file=iframe.js}}
{{include-html |file=iframe.html |fallback=delta.png |fallback_text=You need to enable Javascript to see this IFrame}}
