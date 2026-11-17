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
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}comment {{pipe}}text=This is a comment - View the page source to see{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{comment |text=This is a comment - View the page source to see.}}


### `linebreak`
Inserts a linebreak into the page, i.e. it forces the text to be on a new line.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `'{{leftcurlybracket}}{{leftcurlybracket}}linebreak{{rightcurlybracket}}{{rightcurlybracket}}'`{{linebreak}}
**Example output:** '{{linebreak}}'


### `softbreak`
Inserts a soft linebreak into the page source, but does not force the HTML text to be on a new line.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `'{{leftcurlybracket}}{{leftcurlybracket}}softbreak{{rightcurlybracket}}{{rightcurlybracket}}'`{{linebreak}}
**Example output:** '{{softbreak}}'


### `leftcurlybracket`
Inserts a left curly bracket into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}leftcurlybracket{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{leftcurlybracket}}


### `rightcurlybracket`
Inserts a right curly bracket into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}rightcurlybracket{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{rightcurlybracket}}


### `pipe`
Inserts a pipe into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}pipe{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{pipe}}


### `dash`
Inserts a dash into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}dash{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{dash}}


### `amp`
Inserts an amphersand into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}amp{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{amp}}


### `nbsp`
Inserts a no-break space into the page.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}nbsp{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** a{{nbsp}}b



## Misc

### `heading`
Inserts a heading into the page. The heading will have an anchor, so that it can be linked to directly.

In the example below, you can direct the browser straight to the resulting heading by adding <a href="#Example-heading">`#Example-heading` to the URL</a>.

**Arguments:**
| Argument     | Status    | Description                                     |
| :----------- | :-------- | :---------------------------------------------- |
| `level`      | Mandatory | The level of the heading. Valid values are 1-6. |
| `title`      | Mandatory | The text in the heading.                        |
| `link`       | Optional  | The anchor link to be insered. If not given, the `title` will be turned into an anchor text. |

**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}heading {{pipe}}level=4 {{pipe}}title=Example heading{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:**{{linebreak}}
{{heading |level=4 |title=Example heading}}


### `article`
Marks a page as an article, This will insert a div with the author's name, the date of the article and an automatically calculated reading time approximation. A div with a list of categories will also be inserted.

**Arguments:**
| Argument     | Status    | Description                                   |
| :----------- | :-------- | :-------------------------------------------- |
| `date`       | Mandatory | The date to put in the heading.               |
| `author`     | Mandatory | The name of the author to put in the heading. |
| `categories` | Mandatory | A list of categories.                         |
| `time`       | Pseudo    | Don't provide this argument manually; the engine will do it for you! Generated approximation of how long it will take to read the page. |

**Side effects:**
* The number of words of the article is calculated, and based on an average reading speed of 230 words per minute, the amount of time to read the article is calculated (if over 5 minutes, it will be rounded to the nearest multiple of 5) and inserted in the `time` argument.

**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}article {{pipe}}date=2022-11-04 {{pipe}}author=Johan Sjöblom {{pipe}}categories=technology, templates, incunable{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:**{{linebreak}}
{{article |date=2022-11-04 |author=Johan Sjöblom |categories=technology, templates, incunable}}


### `begincode`
Inserts a code block. It will treat everything between the `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endcode{{rightcurlybracket}}{{rightcurlybracket}}` template as code to be put into a block. Every line will be wrapped between `<span class="line">` and `</span>`. All `<` and `>` characters will be replaced with `{{amp}}lt;` and `{{amp}}gt;`, respectively, so that the code is not interpreted as HTML.

The syntax highlighting from [GlyphDrawing.Club](https://blog.glyphdrawing.club/font-with-built-in-syntax-highlighting/) is applied by the font itself, and the colours can be customized in the CSS. It is not perfect, but it is neat. The line numbering is applied by the CSS.


**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}
function add(a, b) {
  return a + b;
}
console.log(add(1, 2));
{{leftcurlybracket}}{{leftcurlybracket}}endcode{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{begincode}}
function add(a, b) {
  return a + b;
}
console.log(add(1, 2));
{{endcode}}


### `endcode`
Ends a code block. Fverything between the `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endcode{{rightcurlybracket}}{{rightcurlybracket}}` template will be put into a block. See the `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` template for more details.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}
fn read_uncompressed_pixels(width: u16, height: u16, pixels: Vec<u8>) -> Vec<Vec<u8>> {
  let mut raw_row_data = Vec::with_capacity(height as usize);
  for row in 0..height {
    let start = row as usize * width as usize;
    let row_data = pixels[start..start + width as usize].to_vec();
    raw_row_data.push(row_data.clone());
  }
  raw_row_data
}
{{leftcurlybracket}}{{leftcurlybracket}}endcode{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{begincode}}
fn read_uncompressed_pixels(width: u16, height: u16, pixels: Vec<u8>) -> Vec<Vec<u8>> {
  let mut raw_row_data = Vec::with_capacity(height as usize);
  for row in 0..height {
    let start = row as usize * width as usize;
    let row_data = pixels[start..start + width as usize].to_vec();
    raw_row_data.push(row_data.clone());
  }
  raw_row_data
}
{{endcode}}

### `codeblock_before`
Denotes the start of a code-block. This template should not be explicitly inserted -- use `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` instead! The engine will modify each line inside the `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` block, and automatically insert `{{leftcurlybracket}}{{leftcurlybracket}}codeblock_before{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}codeblock_before{{rightcurlybracket}}{{rightcurlybracket}}
int main() {{leftcurlybracket}}
  printf("Hello, World!");
  return 0;
{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}codeblock_after{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{codeblock_before}}
int main() {
printf("Hello, World!");
return 0;
}
{{codeblock_after}}

### `codeblock_after`
Denotes the end of a code-block. This template should not be explicitly inserted -- use `{{leftcurlybracket}}{{leftcurlybracket}}endcode{{rightcurlybracket}}{{rightcurlybracket}}` instead! The engine will modify each line inside the `{{leftcurlybracket}}{{leftcurlybracket}}begincode{{rightcurlybracket}}{{rightcurlybracket}}` block, and automatically insert `{{leftcurlybracket}}{{leftcurlybracket}}codeblock_after{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}codeblock_before{{rightcurlybracket}}{{rightcurlybracket}}
int main() {{leftcurlybracket}}
  printf("Hello, World!");
  return 0;
{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}codeblock_after{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{codeblock_before}}
int main() {
printf("Hello, World!");
return 0;
}
{{codeblock_after}}


### `beginquote`
The beginning of a quote.

**Arguments:**
| Argument       | Status    | Description                      |
| :------------- | :-------- | :------------------------------- |
| `quote-source` | Mandatory | The person or opus being quoted. |
| `quote-time`   | Optional  | The time the quote was made.     |

**Side effects:**
* If the `quote-time` argument is given, it will be propagated into the `{{leftcurlybracket}}{{leftcurlybracket}}quote-time{{rightcurlybracket}}{{rightcurlybracket}}` template, which will be inserted just after the quote block.

**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}beginquote {{pipe}}quote-source=Abraham Lincoln {{pipe}}quote-time=2025-12-11 18:39:41{{rightcurlybracket}}{{rightcurlybracket}}
Don't believe everything you read on the Internet.
{{leftcurlybracket}}{{leftcurlybracket}}endquote{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{beginquote |quote-source=Abraham Lincoln |quote-time=2025-12-11 18:39:41}}
Don't believe everything you read on the Internet.
{{endquote}}


### `endquote`
The ending of a quote.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}beginquote {{pipe}}quote-source=Abraham Lincoln {{pipe}}quote-time=2025-12-11 18:39:41{{rightcurlybracket}}{{rightcurlybracket}}
Don't believe everything you read on the Internet.
{{leftcurlybracket}}{{leftcurlybracket}}endquote{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{beginquote |quote-source=Abraham Lincoln |quote-time=2025-12-11 18:39:41}}
Don't believe everything you read on the Internet.
{{endquote}}


### `quote_before`
Denotes the start of a quote-block. This template should not be explicitly inserted -- use `{{leftcurlybracket}}{{leftcurlybracket}}beginquote{{rightcurlybracket}}{{rightcurlybracket}}` instead! The engine will modify read each line inside the `{{leftcurlybracket}}{{leftcurlybracket}}beginquote{{rightcurlybracket}}{{rightcurlybracket}}` block, and automatically insert `{{leftcurlybracket}}{{leftcurlybracket}}quote_before{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}quote_before{{rightcurlybracket}}{{rightcurlybracket}}
Don't believe everything you read on the Internet.
{{leftcurlybracket}}{{leftcurlybracket}}quote_after {{pipe}}quote-source=Abraham Lincoln{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{quote_before}}
Don't believe everything you read on the Internet.
{{quote_after |quote-source=Abraham Lincoln}}

### `quote_after`
Denotes the end of a quote-block. This template should not be explicitly inserted -- use `{{leftcurlybracket}}{{leftcurlybracket}}endquote{{rightcurlybracket}}{{rightcurlybracket}}` instead! The engine will read each line inside the `{{leftcurlybracket}}{{leftcurlybracket}}beginquote{{rightcurlybracket}}{{rightcurlybracket}}` block, and automatically insert `{{leftcurlybracket}}{{leftcurlybracket}}quote_after{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:**
| Argument       | Status    | Description                      |
| :------------- | :-------- | :------------------------------- |
| `quote-source` | Mandatory | The person or opus being quoted. |

**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}quote_before{{rightcurlybracket}}{{rightcurlybracket}}
Don't believe everything you read on the Internet.
{{leftcurlybracket}}{{leftcurlybracket}}quote_after {{pipe}}quote-source=Abraham Lincoln{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{quote_before}}
Don't believe everything you read on the Internet.
{{quote_after |quote-source=Abraham Lincoln}}


### `quote-time`
The time of a quote.

**Arguments:**
| Argument       | Status    | Description                  |
| :------------- | :-------- | :--------------------------- |
| `quote-time`   | Mandatory | The time the quote was made. |

**Side effects:** None{{linebreak}}
**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}quote-time {{pipe}}quote-time=2025-12-11 18:39:41{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:**{{linebreak}}
{{quote-time |quote-time=2025-12-11 18:39:41}}



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

**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}img {{pipe}}file=smiley.png {{pipe}}title=Happy
{{pipe}}class=custom-class{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:** {{img |file=smiley.png |title=Happy |class=custom-class}}


### `imgframe`
Inserts an image in a frame, with an associated caption and counter. One can also insert an iframe in addition, in which case the image works as a fallback if the user has disabled Javascript.

**Arguments:**
| Argument | Status    | Description |
| :------- | :-------- | :---------- |
| `file`   | Mandatory | The name of the image file. If `elem`  argument is given, this will be the fallback image if the user has disabled Javascript. |
| `title`  | Mandatory | The caption of the image, as well as the alt-text. |
| `ref`    | Optional  | An id referring to the numeric counter of the caption text. Use the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template to retrieve the numeric counter. |
| `elem`   | Optional  | The path to an iframe that can be included. If given, this will set the class of the image in the `file` argument to be "fallback", so the iframe takes precedence over the image in the `file` argument. |
| `class`  | Optional  | The CSS-class to use for the image. |
| `num`    | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is the numeric counter of the caption text. |

**Side effects:**
* The path given in the `file` and `frame` arguments will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* An image counter is incremented for each encountered `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}` template. The number of the current image is inserted as the `num` argument.
* If the `ref` argument is given, the image counter is written to a temporary `reflist`-file, in the form of a key-value pair. The key is the value of the `ref` argument, and the value is the image counter. This can later be referred to using the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.
* If the `frame` argument is given, then the image will have class "fallback", and the `elem` argument will be overwritten with an `iframe` HTML tag, loading the page given in the `elem` argument. If the `frame` argument is not given, the class of the image will be empty, and the `frame` argument will be empty.

**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}imgframe {{pipe}}ref=rider {{pipe}}file=rider.jpg {{pipe}}title=Horses of yore{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:**{{linebreak}}
{{imgframe |ref=rider |file=rider.jpg |title=Horses of yore}} {{comment |text=Source: Bibliotheca Spenceriana; or, A descriptive catalogue of the library of George John, earl Spencer - https://archive.org/details/bibliothecaspenc03spen/mode/1up?view=theater}}


### `thumbnail`
Inserts a gallery with one or many images. The images can be clicked on to be enlarged.

**Arguments:**
| Argument | Status    | Description                                          |
| :------- | :-------- | :--------------------------------------------------- |
| `title`  | Mandatory | The title of the image when hovering with the mouse. |
| `small`  | Mandatory | The name of the thumbnail file.                      |
| `large`  | Mandatory | The name of the large image file.                    |
| `num`    | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is a numeric counter, needed for technical reasons. |
| `id`     | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is a unique identifier of the current group of thumbnails. |

**Side effects:**
* This template must be surrounded by `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails_after{{rightcurlybracket}}{{rightcurlybracket}}`, but if these are not present, the engine will insert them.
* The path given in the `small` and `large` arguments will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* An image counter is incremented for each encountered `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` template. The number of the current image is inserted as the `num` argument.
* An id is inserted for each encountered group of `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` templates. The id is inserted as the `id` argument, and will also be written to the next `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails_after{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example input:** `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Pretty candles {{pipe}}small=candles_small.png {{pipe}}large=candles.jpg{{rightcurlybracket}}{{rightcurlybracket}}`{{linebreak}}
**Example output:**{{linebreak}}
{{thumbnail |title=Pretty candles |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `thumbnails`
Denotes the start of a gallery, and must come before the first `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` of the gallery. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the gallery lacks the starting template and insert it. When it is automatically inserted, the `title` argument of the first `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` will be used as the `text` argument for the inserted `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:**
| Argument | Status    | Description                                                                                                   |
| :------- | :-------- | :------------------------------------------------------------------------------------------------------------ |
| `text`   | Mandatory | Text to display before the gallery starts, to give the website guest an idea about what the gallery is about. |

**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}thumbnails {{pipe}}text=Candles and trees in a gallery:{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Candles {{pipe}}small=candles_small.png {{pipe}}large=candles.jpg{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Trees   {{pipe}}small=trees_small.png   {{pipe}}large=trees.png{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{thumbnails |text=Candles and trees in a gallery:}}
{{thumbnail |title=Candles |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
{{thumbnail |title=Trees   |small=trees_small.png   |large=trees.png}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Laudtee_Meenikunnos.jpg}}

### `thumbnails_after`
Denotes the end of a gallery, and must come after the last `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` of the gallery. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the gallery lacks the ending template and insert it.

**Arguments:**
| Argument | Status    | Description |
| :------- | :-------- | :---------- |
| `id`     | Pseudo    | Don't provide this argument manually; the engine will do it for you! It is a unique identifier of the current group of thumbnails. |

**Side effects:**
* An id is inserted for each encountered group of `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` templates. The id is inserted as the `id` argument of the `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` templates, and will also be written to the next `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails_after{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}thumbnails {{pipe}}text=Candles and trees in a gallery:{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Candles {{pipe}}small=candles_small.png {{pipe}}large=candles.jpg{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Trees   {{pipe}}small=trees_small.png   {{pipe}}large=trees.png{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnails_after{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
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
* The template itself will be replaced by `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}`, followed by the equation given in the `eq` argument, followed by `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}`. The `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template will have the argument `class` hardcoded to `inlinemath`, the argument `style` hardcoded to `textstyle` and the argument `newlines` hardcoded to `false`.

**Example input:** `If {{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=t{{rightcurlybracket}}{{rightcurlybracket}} is the temperature, then {{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\Delta t{{rightcurlybracket}}{{rightcurlybracket}} could refer to a difference between two temperature systems.`{{linebreak}}
**Example output:** If {{math |eq=t}} is the temperature, then {{math |eq=\Delta t}} could refer to a difference between two temperature systems.


### `beginmath`
Inserts a [LaTeX](https://en.wikipedia.org/wiki/LaTeX) mathematical equation. It will treat everything between the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}` template as an equation, and turn it into [MathML](https://en.wikipedia.org/wiki/MathML).

**Arguments:**
| Argument   | Status   | Description |
| :--------- | :------- | :---------- |
| `style`    | Optional | The style to typeset the equations with. For equations in paragraphs, it is recommended to use `textstyle` (in this case it is recommended to use the `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` template, which will set the style to `textstyle` automatically). For equations on lines by themselves, it is recommended to use `displaystyle`. The default value if this argument is omitted is `displaystyle`. |
| `newlines` | Optional | Whether the generated MathML should have newlines or not. One reason for preventing this is if this template is within a list or another template, which would pose a problem since templates can't span over multiple lines. The default value if this argument is omitted is `true`. |

**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
a_1 + a_2 + ... + a_n = \\sum_{{leftcurlybracket}}i = 1{{rightcurlybracket}}^n a_{{leftcurlybracket}}i{{rightcurlybracket}}\\,
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{beginmath}}
a_1 + a_2 + ... + a_n = \sum_{i = 1}^n a_{i}\,
{{endmath}}


### `endmath`
Ends a mathematical equation. Everything between the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template and the `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}` template will be treated as an equation. See the `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` template for more details.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
\\sum_{{leftcurlybracket}}i=1{{rightcurlybracket}}^n i = \\frac{{leftcurlybracket}}n(n+1){{rightcurlybracket}}{{leftcurlybracket}}2{{rightcurlybracket}}\\,
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
{{beginmath}}
\sum_{i=1}^n i = \frac{n(n+1)}{2}\,
{{endmath}}


### `mathref`
Will typeset an equation number in parenthesis to the right of the equation. The equation number can be retrieved with the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Arguments:**
| Argument | Status    | Description |
| :------- | :-------- | :---------- |
| `ref`    | Mandatory | An id referring to the equation number to the right of the equation. Use the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template to retrieve the equation number. |

**Side effects:**
* For each encountered `{{leftcurlybracket}}{{leftcurlybracket}}mathref{{rightcurlybracket}}{{rightcurlybracket}}` template, an equation counter is incremented and written to a temporary `reflist`-file, in the form of a key-value pair. The key is the value of the `ref` argument, and the value is the image counter. This can later be referred to using the `{{leftcurlybracket}}{{leftcurlybracket}}ref{{rightcurlybracket}}{{rightcurlybracket}}` template.

**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
e^{{leftcurlybracket}}i\\theta{{rightcurlybracket}} = \\cos\\theta + i\\sin \\theta  {{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**{{linebreak}}
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

**Example input:** `On the example of the imgframe template, the example image has number {{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=rider{{rightcurlybracket}}{{rightcurlybracket}}, and on the mathref template example, the equation has number {{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}.`{{linebreak}}
**Example output:** On the example of the imgframe template, the example image has number {{ref |ref=rider}}, and on the mathref template example, the equation has number {{ref |ref=EulersFormula}}.


### `imglink`
Inserts an image that acts as a link to a different page/website. When the webpage guest hovers over the image, descriptive text is displayed.

**Arguments:**
| Argument      | Status    | Description                                                                     |
| :------------ | :-------- | :------------------------------------------------------------------------------ |
| `link`        | Mandatory | The name of the page/website that the link leads to.                            |
| `img`         | Mandatory | The image to insert as the link.                                                |
| `title`       | Mandatory | The title when hovering over the image, as well as the alt-text of the image.   |
| `description` | Mandatory | A text description that shows when hovering over the image.                     |
| `dir`         | Optional  | If given, the directory will be preprended to the argument in `link` and `img`. |

**Side effects:**
* This template must be surrounded by `{{leftcurlybracket}}{{leftcurlybracket}}imglinklist{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}imglinklist_after{{rightcurlybracket}}{{rightcurlybracket}}`, but if these are not explicitly provided, the engine will insert them automatically.
* UNLESS the path given in the `link` argument starts with "http" or already ends with "html", it will have ".html" appended to it. If the `dir` argument is provided, that value will be prepended.
* UNLESS the path given in the `img` argument starts with "http", it will be modified to be in the sub-directory "[page]-files", where "[page]" is the name of the page where the image is included. If the `dir` argument is provided, that value will be prepended to the sub-directory.
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}imglink {{pipe}}link=images {{pipe}}dir=examples {{pipe}}img=candles_small.png {{pipe}}title=Images {{pipe}}description=A more thorough description of the image templates.{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{imglink |link=images |dir=examples |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `imglinklist`
Denotes the start of one or many image links, and must come before the first `{{leftcurlybracket}}{{leftcurlybracket}}imglink{{rightcurlybracket}}{{rightcurlybracket}}` of the list. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the image links lacks the starting template and insert it.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}imglinklist{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}imglink {{pipe}}link=images {{pipe}}dir=examples {{pipe}}img=candles_small.png {{pipe}}title=Images {{pipe}}description=A more thorough description of the image templates.{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{imglinklist}}
{{imglink |link=images |dir=examples |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}


### `imglinklist_after`
Denotes the end of one or many image links, and must come after the last `{{leftcurlybracket}}{{leftcurlybracket}}imglink{{rightcurlybracket}}{{rightcurlybracket}}` of the list. This template can be explicitly inserted, but may be omitted; the engine will automatically detect that the image links lacks the starting template and insert it.

**Arguments:** None{{linebreak}}
**Side effects:** None{{linebreak}}
**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}imglink {{pipe}}link=images {{pipe}}dir=examples {{pipe}}img=candles_small.png {{pipe}}title=Images {{pipe}}description=A more thorough description of the image templates.{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}imglinklist_after{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{imglink |link=images |dir=examples |img=candles_small.png |title=Images |description=A more thorough description of the image templates.}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
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
| Argument        | Status    | Description                                                                            |
| :-------------- | :-------- | :------------------------------------------------------------------------------------- |
| `file`          | Mandatory | The name of the file to include in an iframe.                                          |
| `fallback`      | Mandatory | A fallback image to be displayed if the viewer of the website has Javascript disabled. |
| `fallback_text` | Mandatory | The text to display along with the fallback image.                                     |
| `id`            | Optional  | The id of the iframe. Used by the size Message to set the correct size of the iframe.  |

**Side effects:**
* If there is no file called "iframe.js" in the folder, it will be generated and included with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`; see above for further description of what this file does.
* The path given in the `file` and `fallback` arguments will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.
* If the `id` argument is not given, it will be inserted, and the value will be the name of the page where the image is included.

**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}include-html {{pipe}}file=iframe.html {{pipe}}fallback=delta.png {{pipe}}fallback_text=Enable Javascript to see a beautiful yellow box. Without Javascript, you get a triangle.{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{include-html |file=iframe.html |fallback=delta.png |fallback_text=Enable Javascript to see a beautiful yellow box. Without Javascript, you get a triangle.}}

### `include-framed-html`
Incunable is written to support static content, but using this template, dynamic content can be included through an iframe. If a user has Javascript disabled, a static fallback image will be displayed instead.

The difference between this template and `{{leftcurlybracket}}{{leftcurlybracket}}include-html{{rightcurlybracket}}{{rightcurlybracket}}` is that the iframe will be included inside a frame with a caption beneath (specifically by replacing this template with an `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`).

A Javascript file, called "iframe.js" is automatically created and inserted (via `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`). This file does two things:
* It replaces the fallback image with the given HTML page.
* It adds a listener for Messages, in order to set the iframe to the right size. This Message needs to be sent from somewhere in your Javascript code, and should be of the form `{{leftcurlybracket}}"id": "[id]", "width": width, "height": height{{rightcurlybracket}}`, where "[id]" must be the same value as the `id` argument to `{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html{{rightcurlybracket}}{{rightcurlybracket}}`.

A Message can be sent for instance like this:
```
window.parent.postMessage({{leftcurlybracket}}"id": "map", "width": "300px", "height": "500px"{{rightcurlybracket}}, "*");
```

By sending a Message with the sizes, you can calculate the space needed to fit the content dynamically.

If there already is a file called "iframe.js" in the folder of the page, then no default script will be generated. Thus, you can overwrite the default behaviour with your own logic. In this case, you need to include this with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`.

**Arguments:**
| Argument   | Status    | Description                                                                            |
| :--------- | :-------- | :------------------------------------------------------------------------------------- |
| `file`     | Mandatory | The name of the file to include in an iframe.                                          |
| `fallback` | Mandatory | A fallback image to be displayed if the viewer of the website has Javascript disabled. |
| `title`    | Mandatory | The text to display along with the fallback image.                                     |
| `id`       | Optional  | The id of the iframe. Used by the size Message to set the correct size of the iframe.  |

**Side effects:**
* If there is no file called "iframe.js" in the folder, it will be generated and included with an `{{leftcurlybracket}}{{leftcurlybracket}}include-script{{rightcurlybracket}}{{rightcurlybracket}}`; see above for further description of what this file does.
* If the `id` argument is not given, it will be inserted, and the value will be the name of the page where the image is included.
* The template itself will be replaced by `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`. The argument `file` of this template will be the `elem` argument of `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`; the argument `fallback` of this template will be the `file` argument of `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`; the argument `title` of this template will be the `title` argument of `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`; the argument `id` of this template will be the `ref` argument of `{{leftcurlybracket}}{{leftcurlybracket}}imgframe{{rightcurlybracket}}{{rightcurlybracket}}`.

**Example input:**
```
{{leftcurlybracket}}{{leftcurlybracket}}include-framed-html {{pipe}}id=framed-html {{pipe}}file=iframe.html {{pipe}}fallback=delta.png {{pipe}}title=Enable Javascript to see a beautiful yellow box. Without Javascript, you get a triangle.{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:**
{{include-framed-html |id=framed-html |file=iframe.html |fallback=delta.png |title=Enable Javascript to see a beautiful yellow box. Without Javascript, you get a triangle.}}


### `include-css`
Includes a CSS file into the `head` section of the HTML document. Thus, it is possible to pass in custom CSS files to individual pages.

**Arguments:**
| Argument | Status    | Description          |
| :------- | :-------- | :------------------- |
| `file`   | Mandatory | CSS file to include. |

**Side effects:**
* Each included CSS will be inserted into the `head` section of the HTML document. This is not done during the "pre run" pass like with other templates; instead this is hardcoded into the html compile script.
* The path given in the `file` argument will be modified to be in the subfolder "[page]-files", where "[page]" is the name of the page where the image is included.

**Example input:**
```
The line and spacing above the headers in this document comes from an included css, "heading-style.css", on the following line, which has been inserted into the HTML `head` section:
{{leftcurlybracket}}{{leftcurlybracket}}include-css {{pipe}}file=heading-style.css{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:** The line and spacing above the headers in this document comes from an included css, "heading-style.css", on the following line, which has been inserted into the HTML `head` section:
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

**Example input:**
```
Animation that is included in the HTML `head` section:
{{leftcurlybracket}}{{leftcurlybracket}}include-script {{pipe}}file=animation.js{{rightcurlybracket}}{{rightcurlybracket}}
```
**Example output:** Animation that is included in the HTML `head` section:
{{include-script |file=animation.js}}
