# Miscellaneous

Commonmark features are supported, such as inlining code and commands like this: `grep -Irin searchstring`.

The [GitHub flavour of Commonmark](https://github.com/github/cmark-gfm) is used, meaning it has support for extensions like tables and ~~Strikethrough~~.[^1]


Linebreaks can be created with `{{leftcurlybracket}}{{leftcurlybracket}}linebreak{{rightcurlybracket}}{{rightcurlybracket}}`,{{linebreak}}
Like{{linebreak}}
this.

Comments are supported. The following text can be seen if you view the source of this document: {{comment |text=This text is hidden.}}


# Templates within templates
There is support for adding templates within templates, like this, where a line break is inserted in the description:
```
{{leftcurlybracket}}{{leftcurlybracket}}imgframe {{pipe}}ref=rider {{pipe}}file=rider.jpg {{pipe}}title=Horses of yore.{{leftcurlybracket}}{{leftcurlybracket}}linebreak{{rightcurlybracket}}{{rightcurlybracket}}From the book Bibliotheca Spenceriana; or, A descriptive catalogue of the library of George John, earl Spencer.{{rightcurlybracket}}{{rightcurlybracket}}
```

{{imgframe |ref=rider |file=rider.jpg |title=Horses of yore.{{linebreak}}From the book Bibliotheca Spenceriana; or, A descriptive catalogue of the library of George John, earl Spencer.}}


# Tables
## Basic table
| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

## Advanced table
| First Header | Second Header | Third Header |
| :----------: | ------------: | :----------- |
| centered     | right         | left         |

# Footnotes
[^1]: Footnotes can also be inserted.
