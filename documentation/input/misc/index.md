# Miscellaneous

Commonmark features are supported, such as inlining code and commands like this: `grep -Irin searchstring`.

The [GitHub flavour of Commonmark](https://github.com/github/cmark-gfm) is used, meaning it has support for extensions like tables and ~~Strikethrough~~.[^1]


The engine supports templating common phrases. For example, there is a template to reference GitHub projects: {{github |repo=incunable}}[^2]

Linebreaks can be created with `{{leftcurlybracket}}{{leftcurlybracket}}linebreak{{rightcurlybracket}}{{rightcurlybracket}}`,{{linebreak}}
Like{{linebreak}}
this.

Comments are supported. The following text can be seen if you view the source of this document: {{comment |text=This text is hidden.}}


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
[^2]: Another footnote.
