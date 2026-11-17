# Images
Images can be included like below. All are from the book [Bibliotheca Spenceriana; or, A descriptive catalogue of the library of George John, earl Spencer](https://archive.org/details/bibliothecaspenc03spen/mode/1up?view=theater).

```
{{leftcurlybracket}}{{leftcurlybracket}}imgframe {{pipe}}ref=death {{pipe}}file=dance_of_death.jpg {{pipe}}title=Dance of Death. Imago Mortis.{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}imgframe {{pipe}}ref=rider {{pipe}}file=rider.jpg {{pipe}}title=Horses of yore.{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}imgframe {{pipe}}ref=ship  {{pipe}}file=ship.jpg  {{pipe}}title=Detailed ship.{{rightcurlybracket}}{{rightcurlybracket}}
```
{{imgframe |ref=death |file=dance_of_death.jpg |title=Dance of Death. Imago Mortis.}}
{{imgframe |ref=rider |file=rider.jpg          |title=Horses of yore.}}
{{imgframe |ref=ship  |file=ship.jpg           |title=Detailed ship.}}

They can be referenced by their enumerated number using `{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=id{{rightcurlybracket}}{{rightcurlybracket}}`; The ship is Figure {{ref |ref=ship}} (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=ship{{rightcurlybracket}}{{rightcurlybracket}}`) while the image of the Dance of Death is Figure {{ref |ref=death}} (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=death{{rightcurlybracket}}{{rightcurlybracket}}`) and the image of the rider is Figure {{ref |ref=rider}} (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=rider{{rightcurlybracket}}{{rightcurlybracket}}`).

Images can also be included inline; `{{leftcurlybracket}}{{leftcurlybracket}}img {{pipe}}file=smiley.png {{pipe}}title=:){{rightcurlybracket}}{{rightcurlybracket}}` results in this: {{img |file=smiley.png |title=:)}}


# Math
[LaTeX](https://en.wikipedia.org/wiki/LaTeX) math equations are supported, and they will be turned into [MathML](https://en.wikipedia.org/wiki/MathML) and included into the paragraph. There are two commands with which math can be included, `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` for (shorter) inline math snippets, and `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` followed by `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}` for multiline equations.

Inline equations can be included using `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}`, like this one: `{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=a_1 + a_2 + ... + a_n = \\sum_{{leftcurlybracket}}i = 1{{rightcurlybracket}}^n a_{{leftcurlybracket}}i{{rightcurlybracket}}\,{{rightcurlybracket}}{{rightcurlybracket}}`, which is typeset into: {{math |eq=a_1 + a_2 + ... + a_n = \sum_{i = 1}^n a_{i}\,}}. Note that for technical reasons, an equation cannot end with "{{rightcurlybracket}}", hence `\,` is inserted at the end of the equation, which adds a tiny space. Using `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` will automatically make the equation compacted, since it is intended for math that is embedded inside the paragraph, and thus needs to take less space.

Longer, or multi-line or more complex equations can be included by placing the tex markup between `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}`. This will automatically make the math be typeset in a more spacious way; see how the following is typeset compared to the inlined equation of the previous paragraph. The characters of the two equations are identical, but they are typeset differently.

```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
a_1 + a_2 + ... + a_n = \\sum_{{leftcurlybracket}}i = 1{{rightcurlybracket}}^n a_{{leftcurlybracket}}i{{rightcurlybracket}}\,
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```

{{beginmath}}
a_1 + a_2 + ... + a_n = \sum_{i = 1}^n a_{i}\,
{{endmath}}

Under the hood, `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` will be turned into `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}` and `{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}`.


## Style
As mentioned, using `{{leftcurlybracket}}{{leftcurlybracket}}math{{rightcurlybracket}}{{rightcurlybracket}}` will typeset equations compacted (using `\\textstyle` of LaTeX). Using `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}`, equations will by default be typeset with `\\displaystyle`. This can be overridden by providing the `style` argument to `{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}`, like this:

```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath {{pipe}}style=textstyle{{rightcurlybracket}}{{rightcurlybracket}}
\\sum_{{leftcurlybracket}}i=1{{rightcurlybracket}}^n i = \\frac{{leftcurlybracket}}n(n+1){{rightcurlybracket}}{{leftcurlybracket}}2{{rightcurlybracket}}\,
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```

{{beginmath |style=textstyle}}
\sum_{i=1}^n i = \frac{n(n+1)}{2}\,
{{endmath}}


## Equations with references
Equations can be referenced by including a `{{leftcurlybracket}}{{leftcurlybracket}}mathref{{rightcurlybracket}}{{rightcurlybracket}}` in the tex markup, like this:

```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
e^{{leftcurlybracket}}i\\theta{{rightcurlybracket}} = \\cos\\theta + i\\sin \\theta  {{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```

{{beginmath}}
e^{i\theta} = \cos\theta + i\sin \theta  {{mathref |ref=EulersFormula}}
{{endmath}}

Equation ({{ref |ref=EulersFormula}}) above is known as Euler's Formula, and the number is referenced by `{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}`. We can evaluate Euler's Formula for {{math |eq=\theta = \pi}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\theta = \\pi{{rightcurlybracket}}{{rightcurlybracket}}`):

```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
\\begin{{leftcurlybracket}}align{{rightcurlybracket}}
  e^{{leftcurlybracket}}i\\pi{{rightcurlybracket}}    &= \\cos{{leftcurlybracket}}\\pi{{rightcurlybracket}} + i \\sin{{leftcurlybracket}}\\pi{{rightcurlybracket}}  &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Pi1{{rightcurlybracket}}{{rightcurlybracket}}\\\\
  e^{{leftcurlybracket}}i\\pi{{rightcurlybracket}}    &= -1 + i\\cdot 0            &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Pi2{{rightcurlybracket}}{{rightcurlybracket}}\\\\
  e^{{leftcurlybracket}}i\\pi{{rightcurlybracket}}    &= -1                       &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Pi3{{rightcurlybracket}}{{rightcurlybracket}}\\\\
  e^{{leftcurlybracket}}i\\pi{{rightcurlybracket}} +1 &= 0                        &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Pi4{{rightcurlybracket}}{{rightcurlybracket}}
\\end{{leftcurlybracket}}align{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```

{{beginmath}}
\begin{align}
  e^{i\pi}    &= \cos{\pi} + i \sin{\pi}  &{{mathref |ref=Pi1}}\\
  e^{i\pi}    &= -1 + i\cdot 0            &{{mathref |ref=Pi2}}\\
  e^{i\pi}    &= -1                       &{{mathref |ref=Pi3}}\\
  e^{i\pi} +1 &= 0                        &{{mathref |ref=Pi4}}
\end{align}
{{endmath}}

In ({{ref |ref=Pi1}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Pi1{{rightcurlybracket}}{{rightcurlybracket}}`) we insert {{math |eq=\pi}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\pi{{rightcurlybracket}}{{rightcurlybracket}}`) into ({{ref |ref=EulersFormula}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}`), i.e. Euler's Formula. In ({{ref |ref=Pi2}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Pi2{{rightcurlybracket}}{{rightcurlybracket}}`) and ({{ref |ref=Pi3}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Pi3{{rightcurlybracket}}{{rightcurlybracket}}`) we solve the equation, and finally in ({{ref |ref=Pi4}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Pi4{{rightcurlybracket}}{{rightcurlybracket}}`), we obtain what is known as [Euler's Identity](https://en.wikipedia.org/wiki/Euler%27s_identity), sometimes called "the most beautiful equation in mathematics".

Of course, cool kids use {{math |eq=\tau}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\tau{{rightcurlybracket}}{{rightcurlybracket}}`) instead of {{math |eq=\pi}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\pi{{rightcurlybracket}}{{rightcurlybracket}}`), see the [Tau Manifesto](https://tauday.com/tau-manifesto). Then we instead get the {{math |eq=\tau}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\tau{{rightcurlybracket}}{{rightcurlybracket}}`) version of Euler's Identity:

```
{{leftcurlybracket}}{{leftcurlybracket}}beginmath{{rightcurlybracket}}{{rightcurlybracket}}
\\begin{{leftcurlybracket}}align{{rightcurlybracket}}
  e^{{leftcurlybracket}}i\\tau{{rightcurlybracket}}   &= \\cos{{leftcurlybracket}}2\\pi{{rightcurlybracket}} + i \\sin{{leftcurlybracket}}2\\pi{{rightcurlybracket}} &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Tau1{{rightcurlybracket}}{{rightcurlybracket}}\\\\
  e^{{leftcurlybracket}}i\\tau{{rightcurlybracket}}   &= 1 + i \\cdot 0             &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Tau2{{rightcurlybracket}}{{rightcurlybracket}}\\\\
  e^{{leftcurlybracket}}i\\tau{{rightcurlybracket}}   &= 1                         &{{leftcurlybracket}}{{leftcurlybracket}}mathref {{pipe}}ref=Tau3{{rightcurlybracket}}{{rightcurlybracket}}
\\end{{leftcurlybracket}}align{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}endmath{{rightcurlybracket}}{{rightcurlybracket}}
```

{{beginmath}}
\begin{align}
  e^{i\tau}   &= \cos{2\pi} + i \sin{2\pi} &{{mathref |ref=Tau1}}\\
  e^{i\tau}   &= 1 + i \cdot 0             &{{mathref |ref=Tau2}}\\
  e^{i\tau}   &= 1                         &{{mathref |ref=Tau3}}
\end{align}
{{endmath}}

In ({{ref |ref=Tau1}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Tau1{{rightcurlybracket}}{{rightcurlybracket}}`) we solve equation ({{ref |ref=EulersFormula}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=EulersFormula{{rightcurlybracket}}{{rightcurlybracket}}`) for {{math |eq=\tau = 2\pi}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\tau = 2\\pi{{rightcurlybracket}}{{rightcurlybracket}}`), and in ({{ref |ref=Tau2}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Tau2{{rightcurlybracket}}{{rightcurlybracket}}`) we simplify. We then obtain the {{math |eq=\tau}} (`{{leftcurlybracket}}{{leftcurlybracket}}math {{pipe}}eq=\\tau{{rightcurlybracket}}{{rightcurlybracket}}`) version of Euler's Identity in ({{ref |ref=Tau3}}) (`{{leftcurlybracket}}{{leftcurlybracket}}ref {{pipe}}ref=Tau3{{rightcurlybracket}}{{rightcurlybracket}}`).


# Galleries
## One Thumbnail
Below is a gallery with one single thumbnail. Just include a `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}`, and the engine will do the rest. The title of the thumbnail will be the title of the gallery (here the title is "Pretty candles:", which is included in the text before the gallery).
```
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Pretty candles: {{pipe}}small=candles_small.png {{pipe}}large=candles.jpg{{rightcurlybracket}}{{rightcurlybracket}} {{leftcurlybracket}}{{leftcurlybracket}}comment {{pipe}}text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg{{rightcurlybracket}}{{rightcurlybracket}}
```

{{thumbnail |title=Pretty candles: |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}

## Many thumbnails
If you want many thumbnails in a gallery, more work is done behind the scenes. The line before the first `{{leftcurlybracket}}{{leftcurlybracket}}thumbnail{{rightcurlybracket}}{{rightcurlybracket}}` should begin with a `{{leftcurlybracket}}{{leftcurlybracket}}thumbnails{{rightcurlybracket}}{{rightcurlybracket}}`, giving an explanatory title to the images.

```
{{leftcurlybracket}}{{leftcurlybracket}}thumbnails {{pipe}}text=Many thumbnails in a gallery below:{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Thumbnail two: {{pipe}}small=candles_small.png {{pipe}}large=candles.jpg{{rightcurlybracket}}{{rightcurlybracket}} {{leftcurlybracket}}{{leftcurlybracket}}comment {{pipe}}text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg{{rightcurlybracket}}{{rightcurlybracket}}
{{leftcurlybracket}}{{leftcurlybracket}}thumbnail {{pipe}}title=Thumbnail three: {{pipe}}small=trees_small.png {{pipe}}large=trees.png{{rightcurlybracket}}{{rightcurlybracket}} {{leftcurlybracket}}{{leftcurlybracket}}comment {{pipe}}text=Source: https://commons.wikimedia.org/wiki/File:Laudtee_Meenikunnos.jpg{{rightcurlybracket}}{{rightcurlybracket}}
```

{{thumbnails |text=Many thumbnails in a gallery below:}}
{{thumbnail |title=Thumbnail two: |small=candles_small.png |large=candles.jpg}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Liesel_22-12-2012_4._Advent.jpg}}
{{thumbnail |title=Thumbnail three: |small=trees_small.png |large=trees.png}} {{comment |text=Source: https://commons.wikimedia.org/wiki/File:Laudtee_Meenikunnos.jpg}}
