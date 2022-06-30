# Template Overview
Here follows an overview of all the templates and their arguments. A template in itself can only perform substitution; no logic is supported. However, some templates have a "pre-run" pass, where arguments can be changed, external programs can be called, other templates can be inserted etc. This is referred to in this document as "Side effects". These side effects are where the convenience of Incunable comes from.

The templates are classified into the categories Decorative, Misc, Images and Includes. In the arguments table below, arguments can have the statuses Mandatory (argument must be provided), Optional (argument may be provided) or Pseudo (argument must **not** be manually provided; it exists for technical reasons but the engine will take care of it for you).


## Decorative

### `comment`
Inserts a comment into the page. It will not be rendered, but it can be seen in the HTML source view.

**Arguments:**
| Argument | Status    | Description                 |
| :------- | :-------- | :-------------------------- |
| `text`   | Mandatory | The content of the comment. |

**Side effects:** None{{linebreak}}
**Example:** (View the page source to see) {{comment |text=This is a comment.}}


### `linebreak`
Inserts a linebreak into the page, i.e. it forces the text to be on a new line.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:** '{{linebreak}}'


### `leftcurlybracket`
Inserts a left curly bracket into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:** {{leftcurlybracket}}


### `rightcurlybracket`
Inserts a right curly bracket into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:** {{rightcurlybracket}}


### `pipe`
Inserts a pipe into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:** {{pipe}}



## Misc

### `github`
Inserts a link to a GitHub repo.

**Arguments:**
| Argument | Status    | Description                       |
| :------- | :-------- | :-------------------------------- |
| `repo`   | Mandatory | The GitHub repository to link to. |

**Side effects:** None{{linebreak}}
**Example:** {{github |repo=incunable}}



## Images

### `img`
Inserts an image. It can be either on a line of its own, or included in inline text.

**Arguments:**
| Argument | Status    | Description                 |
| :------- | :-------- | :-------------------------- |
| `file`   | Mandatory | The name of the image file. |
| `title`  | Mandatory | The alt-text of the image.  |
| `class`  | Optional  | The CSS-class to use.       |

**Side effects:**
* The path given in the `file` argument will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* If the `class` argument is not given, it will be inserted, with an empty value.

**Example:** {{img |file=smiley.png |title=Happy |class=custom-class}}


### `imgframe`
Inserts an image in a frame, with an associated caption and counter.

**Arguments:**
| Argument | Status    | Description                                          |
| :------- | :-------- | :--------------------------------------------------- |
| `file`   | Mandatory | The name of the image file.                          |
| `title`  | Mandatory | The caption of the image, as well as the alt-text.   |
| `ref`    | Optional  | An id referring to the numeric counter of the caption text. Use the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template to retrieve the numeric counter. |
| `num`    | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is the numeric counter of the caption text. |

**Side effects:**
* The path given in the `file` argument will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* An image counter is incremented for each encountered `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}` template. The number of the current image is inserted as the `num` argument.
* If the `ref` argument is given, the image counter is written to a temporary `reflist`-file, in the form of a key-value pair. The key is the value of the `ref` argument, and the value is the image counter. This can later be referred to using the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example:** {{imgframe |ref=rider |file=rider.jpg |title=Horses of yore}} {{comment |text=Source: Bibliotheca Spenceriana; or, A descriptive catalogue of the library of George John, earl Spencer - https://archive.org/details/bibliothecaspenc03spen/mode/1up?view=theater}}

### `thumbnail`
Inserts a gallery with one or many images. The images can be clicked on to be enlarged.

**Arguments:**
| Argument | Status    | Description                                          |
| :------- | :-------- | :--------------------------------------------------- |
| `title`  | Mandatory | The title of the image when hovering with the mouse. |
| `small`  | Mandatory | The name of the thumbnail file.                      |
| `large`  | Mandatory | The name of the large image file.                    |
| `num`    | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is a numeric counter, needed for technical reasons. |

**Side effects:**
* This template must be surrounded by `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails_after{{rightcurlybracket}}{{rightcurlybracket}}`, but if these are not present, the engine will insert them.
* The path given in the `small` and `large` arguments will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* An image counter is incremented for each encountered `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` template. The number of the current image is inserted as the `num` argument.

**Example:**{{linebreak}}
{{thumbnail |title=Pretty candles |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `thumbnails`
Denotes the start of a gallery, and must come before the first `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` of the gallery. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the gallery lacks the starting template and insert it. When it is automatically inserted, the `title` argument of the first `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` will be used as the `text` argument for the inserted `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:**
| Argument | Status    | Description                                                                                                   |
| :------- | :-------- | :------------------------------------------------------------------------------------------------------------ |
| `text`   | Mandatory | Text to display before the gallery starts, to give the website guest an idea about what the gallery is about. |

**Side effects:** None{{linebreak}}
**Example:**
{{thumbnails |text=Candles and trees in a gallery:}}
{{thumbnail |title=Candles |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
{{thumbnail |title=Trees   |small=trees_small.png   |large=trees.png}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Laudtee_Meenikunnos.jpg}}

### `thumbnails_after`
Denotes the end of a gallery, and must come after the last `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` of the gallery. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the gallery lacks the ending template and insert it.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:**
{{thumbnails |text=Candles and trees in a gallery:}}
{{thumbnail |title=Candles |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
{{thumbnail |title=Trees   |small=trees_small.png   |large=trees.png}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Laudtee_Meenikunnos.jpg}}
{{thumbnails_after}}


### `math`
Shorthand notation for inserting a mathematical equation in the middle of a paragraph.

**Arguments:**
| Argument | Status    | Description              |
| :------- | :-------- | :----------------------- |
| `eq`     | Mandatory | The equation to typeset. |

**Side effects:**
* The template itself will be replaced by `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}`, followed by the equation given in the `eq` argument, followed by `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}`. The `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template will have the argument `class` hardcoded to `inlinemath`, and the argument `style` hardcoded to `textstyle`.

**Example:** If {{math |eq=t}} is the temperature, then {{math |eq=\Delta t}} could refer to a difference between two temperature systems.


### `beginmath`
Inserts a mathematical equation. It will treat everything between the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}` template as an equation, typeset it using [LaTeX](https://en.wikipedia.org/wiki/LaTeX), and turn
it into an SVG-image that will be inserted using the `{{leftcurlybracket}}{{leftcurlybracket}}img{{rightcurlybracket}}{{rightcurlybracket}}` template. Any previously encountered equations will be re-used instead of being typeset once again.

**Arguments:**
| Argument | Status   | Description |
| :------- | :------- | :---------- |
| `class`  | Optional | The CSS-class to use on the image, will be passed to the `class` argument of the `{{leftcurlybracket}}{{leftcurlybracket}}img{{rightcurlybracket}}{{rightcurlybracket}}` template that this template will be replaced by. |
| `length` | Optional | For technical reasons, equations have a max-width, which means that long equations using the `{{leftcurlybracket}}{{leftcurlybracket}}mathref{{rightcurlybracket}}{{rightcurlybracket}}` template might be typeset with the reference number on a different line. By providing a larger value in the `length` argument, this can be overcome. Default: 7.1cm |
| `style`  | Optional | The style which LaTeX will typeset the equations with, see [Overleaf](https://sv.overleaf.com/learn/latex/Display_style_in_math_mode) for more information. For equations in paragraphs, this is recommended to be `textstyle` (in this case it is recommended to use the `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` template, which will set the style to `textstyle` automatically). For equations on lines by themselves, it is recommended to use `displaystyle`. The default value if this argument is omitted is `displaystyle`. |

**Side effects:**
* The equation will be typeset with `pdflatex`, cropped with `pdfcrop` and turned into an SVG with `dvisvgm`. These programs need to be installed to run Incunable with the `{{leftcurlybracket}}{{leftcurlybracket}}img{{rightcurlybracket}}{{rightcurlybracket}}` template.
* The resulting SVG will be moved to the "[page]-files" folder, where "[page]" is the name of the page where the equation is included. The temporary input and output files used by `pdflatex` are created in the /tmp storage and is removed after completion.
* The template itself will be replaced by the `{{leftcurlybracket}}{{leftcurlybracket}}img{{rightcurlybracket}}{{rightcurlybracket}}` template. If the `class` argument is set, the value will be given to the `class` argument of the `{{leftcurlybracket}}{{leftcurlybracket}}img{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example:**{{linebreak}}
{{beginmath}}
a_1 + a_2 + ... + a_n = \sum_{i = 1}^n a_{i}
{{endmath}}


### `endmath`
Ends a mathematical equation. Everything between the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}` template will be treated as an equation. See the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template for more details.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:**{{linebreak}}
{{beginmath}}
\sum_{i=1}^n i = \frac{n(n+1)}{2}
{{endmath}}


### `mathref`
Will typeset an equation number in parenthesis to the right of the equation. The equation number can be retrieved with the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Arguments:**
| Argument | Status    | Description |
| :------- | :-------- | :---------- |
| `ref`    | Mandatory | An id referring to the equation number to the right of the equation. Use the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template to retrieve the equation number. |

**Side effects:**
* For each encountered `{{leftcurlybracket}}{{leftcurlybracket}}mathref{{rightcurlybracket}}{{rightcurlybracket}}` template, an equation counter is incremented and written to a temporary `reflist`-file, in the form of a key-value pair. The key is the value of the `ref` argument, and the value is the image counter. This can later be referred to using the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example:**{{linebreak}}
{{beginmath}}
e^{i\theta} = \cos\theta + i\sin \theta  {{mathref |ref=EulersFormula}}
{{endmath}}


### `ref`
Will insert a reference to an image or equation.

**Arguments:**
| Argument | Status    | Description                                    |
| :------- | :-------- | :--------------------------------------------- |
| `ref`    | Mandatory | Id of the image or equation being referred to. |
| `num`    | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is the number being referred to by the reference. |

**Side effects:**
* Will read the temporarily created `reflist` file, which holds all references as key-value pairs. It will find the corresponding value to the key given in the `ref` argument, and insert the `num` argument with this value.

**Example:** On the example of the `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}` template, the example image has number {{ref |ref=rider}}, and on the `{{leftcurlybracket}}{{leftcurlybracket}}mathref{{rightcurlybracket}}{{rightcurlybracket}}` template example, the equation has number {{ref |ref=EulersFormula}}.


### `imglink`
Inserts an image that acts as a link to a different page/website. When the webpage guest hovers over the image, descriptive text is displayed.

**Arguments:**
| Argument      | Status    | Description                                                                   |
| :------------ | :-------- | :---------------------------------------------------------------------------- |
| `link`        | Mandatory | The name of the page/website that the link leads to.                          |
| `img`         | Mandatory | The image to insert as the link.                                              |
| `title`       | Mandatory | The title when hovering over the image, as well as the alt-text of the image. |
| `description` | Mandatory | A text description that shows when hovering over the image.                   |

**Side effects:**
* This template must be surrounded by `{{leftcurlybracket}}{{leftcurlybracket}}imglinklist{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}imglinklist_after{{rightcurlybracket}}{{rightcurlybracket}}`, but if these are not explicitly provided, the engine will insert them automatically.
* UNLESS the path given in the `link` argument starts with "http" or already ends with "html", it will have ".html" appended to it.
* UNLESS the path given in the `img` argument starts with "http", it will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.

**Example:**
{{imglink |link=images |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `imglinklist`
Denotes the start of one or many image links, and must come before the first `{{leftcurlybracket}}{{leftcurlybracket}}imglink{{rightcurlybracket}}{{rightcurlybracket}}` of the list. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the image links lacks the starting template and insert it.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:**
{{imglinklist}}
{{imglink |link=images |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `imglinklist_after`
Denotes the end of one or many image links, and must come after the last `{{leftcurlybracket}}{{leftcurlybracket}}imglink{{rightcurlybracket}}{{rightcurlybracket}}` of the list. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the image links lacks the starting template and insert it.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example:**
{{imglink |link=images |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
{{imglinklist_after}}



## Includes

### `include-html`
Incunable is written to support static content, but using this template, dynamic content can be included through an iframe. If a user has Javascript disabled, a static fallback image will be displayed instead. 

A Javascript file, called "iframe.js" is automatically created and inserted (via `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`). This file does two things:
* It replaces the fallback image with the given HTML page.
* It adds a listener for Messages, in order to set the iframe to the right size. This Message needs to be sent from somewhere in your Javascript code, and should be of the form `{{leftcurlybracket}}"id": "[id]", "width": width, "height": height{{rightcurlybracket}}`, where "[id]" must be the same value as the `id` argument to `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}`.

A Message can be sent for instance like this:
```
window.parent.postMessage({{leftcurlybracket}}"id": "map", "width": "300px", "height": "500px"{{rightcurlybracket}}, "*");
```

By sending a Message with the sizes, you can calculate the space needed to fit the content dynamically.

If there already is a file called "iframe.js" in the folder of the page, then no default script will be generated. Thus, you can overwrite the default behaviour with your own logic. In this case, you need to include this with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:**
| Argument        | Status    | Description                                                                           |
| :-------------- | :-------- | :------------------------------------------------------------------------------------ |
| `file`          | Mandatory | The name of the file to include in an iframe.                                         |
| `fallback`      | Mandatory | A fallback image to be displayed if the website guest has Javascript disabled.        |
| `fallback_text` | Mandatory | The text to display along with the fallback image.                                    |
| `id`            | Optional  | The id of the iframe. Used by the size Message to set the correct size of the iframe. |

**Side effects:**
* If there is no file called "iframe.js" in the folder, it will be generated and included with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`; see above for further description of what this file does.
* The path given in the `file` and `fallback` arguments will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* If the `id` argument is not given, it will be inserted, and the value will be the name of the page where the image is included.

**Example:**
{{include-html |file=iframe.html |fallback=delta.png |fallback_text=Enable Javascript to see a beautiful yellow box. Without Javascript, you get a triangle.}}


### `include-css`
Includes a CSS file into the `head` section of the HTML document. Thus it is possible to pass in custom CSS files to individual pages.

**Arguments:**
| Argument | Status    | Description          |
| :------- | :-------- | :------------------- |
| `file`   | Mandatory | CSS file to include. |

**Side effects:** 
* Each included CSS will be inserted into the `head` section of the HTML document. This is not done during the "pre run" pass like with other templates; instead this is hardcoded into the html compile script.
* The path given in the `file` argument will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.

**Example:** The line and spacing above the headers in this document comes from an included css, "heading-style.css", on the following line, which has been inserted into the HTML `head` section:
{{include-css |file=heading-style.css}}


### `include-script`
Includes a script file into the `head` section of the HTML document. Via custom scripts, you have full control over the resulting page and can make it dynamic. However, keep in mind that not all website guests have Javascript enabled.

**Arguments:**
| Argument | Status    | Description             |
| :------- | :-------- | :---------------------- |
| `file`   | Mandatory | Script file to include. |

**Side effects:** 
* Each included script will be inserted into the `head` section of the HTML document. This is not done during the "pre run" pass like with other templates; instead this is hardcoded into the html compile script.
* The path given in the `file` argument will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.

**Example:** Animation that is included in the HTML `head` section:
{{include-script |file=animation.js}}
