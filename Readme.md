# Incunable

Incunable is a templating engine, which operates on [Markdown/CommonMark documents](https://commonmark.org) and turns them into for example webpages. In the Markdown, you can use pre-defined templates, on which variable substitution will be performed.

The engine is made up of a series of awk scripts, along with some Bash and Python thrown in to manage the scripts.

Each page to process should have its own directory. The page content must be in a file called index.md, and any images or resources should also be in this directory. For each directory *[dir]*, Incunable will take the page content, work through any templates, and output a file called "[dir].html" and a folder called "[dir]-files" where the images and resources are (where "[dir]" is the name of the directory). Any directory structure of the input will be preserved in the output.

Incunable is well suited for creating simple static webpages, although dynamic content can be included as well.


## Template example
As an example, consider the template `{{imgframe |file=bees.jpg |title=Bees entering their hive |ref=beeimage}}`. Since the engine has a template called `imgframe`, it will be read and the content of the arguments will be inserted into the template. This is the content of the `imgframe` template:
```
<figure class="imageframe">
<img src="${file}" alt="${title}" />
<figcaption>Figure ${num}: ${title}</figcaption>
</figure>
```

We provided three arguments to the template: `file`, `title` and `ref`. In `imgframe` above there are three variables to substitute: `file`, `title` and `num`. The reason for the difference is that the original template that the user inputs, is transformed during the pre-processing step of the engine.

Some templates have pre-processing scripts associated with them, and before performing the substitution, a pre-processing run will execute these scripts as needed. They do different things for different templates, and tend to have side-effects. The pre-processing script for `imgframe` will do a few different things:
* It will adjust the `file`-argument so that it is relative to the right path.
* It will increment a counter for each `imgframe` that it encounters, and write this number associated with the `ref` argument to a temporary file. This allows the `ref` template to later fetch this number and from the text refer to the figure.
* It will insert the `num` variable into the `imgframe` reference.

In other words, for this template the pre-processing step will **modify** the `file`-argument, **insert** a new argument `num`, and it will **write** an association between the `ref` argument and the `num` to a temporary file.

## Pre-processing transformations
Some templates will as output write **other** templates; for example `{{math |eq=\Delta}}` will be turned into `{{beginmath}}\Delta{{endmath}}`, and this LaTeX-code will be made into an SVG and the template turned into `{{img |file=eq_0.svg |title=\Delta}}`. Thus, `math` produces `beginmath` and `endmath`, and `beginmath` produces `img`.

The engine takes care of creating a tree of the order in which the pre-processing scripts will be run, so that one can take over from another.


## Algorithm
For each input file, the following operations will be performed:
1. The pre-processing scripts will be run, in the right order.
2. Template substitution is performed.
3. The document is turned into HTML with [cmark-gfm](https://github.com/github/cmark-gfm) (i.e. the GitHub fork of cmark).

## Template documentation
Documentation of the templates and different features can be found in the `./documentation/output` directory.

## Usage
Input markdown files are turned into HTML files using the compile script in the HTML directory. The script requires three arguments; The directory with input files, the directory where to write to, and a resources directory with header, footer and any custom resources.

### Example usage
The documentation of the project can be generated like this:

```
./html/compile.sh documentation/input documentation/output documentation/input_resources
```

## Testing
There is a small test script that can be used to verify that the code and templates behave as expected. It will output the documentation in the `/tmp` directory, and verify that it is identical to what is in the `./documentation/output` directory. Run it with `./run_tests.sh`.

## Project name
Wikipedia says that "an incunable is a book, pamphlet, or broadside that was printed in the earliest stages of printing in Europe, up to the year 1500". In other words, a primitive form of automated printing. The likeliness is that this engine is a rudimentary template substitution engine, less performant and less versatile than more complex alternatives, but it is rather by design primitive.
